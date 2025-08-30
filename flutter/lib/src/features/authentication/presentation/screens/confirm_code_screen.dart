import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/presentation/custom_button.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/features/authentication/application/forgot_password_cubit.dart';
import 'package:mentor_link/src/features/authentication/presentation/widgets/sign_up_prompt.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_styles.dart' show Styles;

class ConfirmCodeScreen extends StatefulWidget {
  final String email;
  const ConfirmCodeScreen({super.key, required this.email});

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  String _code = '';
  bool _canResend = true;
  int _cooldown = 0;
  Timer? _timer;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _startCooldown([int seconds = 30]) {
    setState(() {
      _canResend = false;
      _cooldown = seconds;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_cooldown <= 1) {
        t.cancel();
        setState(() {
          _canResend = true;
          _cooldown = 0;
        });
      } else {
        setState(() => _cooldown -= 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 56.h,
      textStyle: Styles.boldTextStyle20.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 20.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: theme.colorScheme.primary, width: 1),
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );

    return Scaffold(
      appBar: const CustomAppBar(text: "Confirmation Code"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              state.maybeWhen(
                codeVerified: () {
                  GoRouter.of(context).push(
                    AppRoutePaths.resetPasswordScreen,
                    extra: {'email': widget.email, 'resetCode': _code},
                  );
                },
                codeSent: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('A new code has been sent.')),
                  );
                },
                failure: (f) => _showError(f.toString()),
                orElse: () {},
              );
            },
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      " Check your Email",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Center(
                    child: Pinput(
                      length: 5,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration?.copyWith(
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                      disabledPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration?.copyWith(
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration?.copyWith(
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                      onChanged: (v) => _code = v.trim(),
                      onCompleted: (v) => _code = v.trim(),
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      autofocus: true,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return CustomButton(
                        text: isLoading ? "Verifying..." : "Verify code",
                        onPressed: isLoading
                            ? () {}
                            : () {
                                context.read<ForgotPasswordCubit>().verifyCode(
                                  email: widget.email,
                                  resetCode: _code,
                                );
                              },
                      );
                    },
                  ),
                  SizedBox(height: 17.h),
                  SignUpPrompt(
                    onTap: () {
                      if (!_canResend) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please wait $_cooldown s to resend.',
                            ),
                          ),
                        );
                        return;
                      }
                      context.read<ForgotPasswordCubit>().sendCode(
                        widget.email,
                      );
                      _startCooldown();
                    },
                    text1: _canResend
                        ? "Don’t receive the code? "
                        : "Resend available in $_cooldown s. ",
                    text2: "Resend",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
