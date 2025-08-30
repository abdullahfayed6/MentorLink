import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/core/utils/validators.dart';
import 'package:mentor_link/src/features/authentication/presentation/widgets/google_icon.dart';

import '../../../../core/presentation/custom_button.dart';
import '../../../../core/presentation/custom_check_box.dart';
import '../../../../core/presentation/custom_title_with_textfield.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../application/auth_cubit.dart';
import '../widgets/custom_divider.dart';
import '../widgets/sign_up_prompt.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _remember = false;

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Log in"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                loading: () {},
                authenticated: (_) {
                  GoRouter.of(context).go(AppRoutePaths.rootScreen);
                },
                failure: (f) {
                  _showError(f.toString());
                },
                orElse: () {},
              );
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 78.h),
                    CustomTitleWithTextField(
                      title: "Email or phone",
                      hintText: 'Enter your email or phone',
                      icon: Icons.email_outlined,
                      borderColor: context.colorScheme.primary,
                      hintStyle: Styles.textStyle16.copyWith(
                        color: AppColors.onHintColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChange: (v) => _email = v.trim(),
                      validator: Validators.emailOrPhone,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 25.h),
                    CustomTitleWithTextField(
                      title: "Password",
                      hintText: "Enter your password",
                      icon: Icons.vpn_key_rounded,
                      isObscure: true,
                      borderColor: context.colorScheme.primary,
                      hintStyle: Styles.textStyle16.copyWith(
                        color: AppColors.onHintColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChange: (v) => _password = v,
                      validator: Validators.requiredField,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(
                            context,
                          ).push(AppRoutePaths.forgetPasswordScreen);
                        },
                        child: Text(
                          "Forgot password?",
                          style: Styles.textStyle16.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: context.colorScheme.primary,
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    CustomCheckBox(
                      text: "Remember me",
                      onChanged: (value) {
                        setState(() => _remember = value);
                      },
                    ),
                    SizedBox(height: 25.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return CustomButton(
                          text: isLoading ? "Loading..." : "Log in",
                          onPressed: isLoading
                              ? () {}
                              : () {
                                  final isValid =
                                      _formKey.currentState?.validate() ??
                                      false;
                                  if (isValid) {
                                    context.read<AuthCubit>().login(
                                      email: _email,
                                      password: _password,
                                    );
                                  }
                                },
                        );
                      },
                    ),
                    SizedBox(height: 50.h),
                    const CustomDivider(),
                    SizedBox(height: 10.h),
                    const GoogleIcon(),
                    SizedBox(height: 16.h),
                    SignUpPrompt(
                      text1: "Don’t have an account? ",
                      text2: "Sign up",
                      onTap: () {
                        GoRouter.of(context).push(AppRoutePaths.signUpScreen);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
