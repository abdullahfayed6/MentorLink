import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/presentation/guide_line.dart';
import 'package:mentor_link/src/core/utils/validators.dart';

import '../../../../core/presentation/custom_button.dart';
import '../../../../core/presentation/custom_title_with_textfield.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';
import '../../application/forgot_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String resetCode;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.resetCode,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _pw1 = '';
  String _pw2 = '';

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Reset Password"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              state.maybeWhen(
                passwordReset: () {
                  GoRouter.of(context).go(AppRoutePaths.successChangePw);
                },
                failure: (f) => _showError(f.toString()),
                orElse: () {},
              );
            },
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 78.h),
                    CustomTitleWithTextField(
                      title: "New Password",
                      hintText: 'Enter your new password',
                      icon: Icons.vpn_key_rounded,
                      isObscure: true,
                      borderColor: context.colorScheme.primary,
                      hintStyle: Styles.textStyle16.copyWith(
                        color: AppColors.onHintColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChange: (v) => _pw1 = v,
                      validator: Validators.strongPassword,
                    ),
                    SizedBox(height: 36.h),
                    CustomTitleWithTextField(
                      title: "Password",
                      hintText: "Enter your new password ",
                      icon: Icons.vpn_key_rounded,
                      isObscure: true,
                      borderColor: context.colorScheme.primary,
                      hintStyle: Styles.textStyle16.copyWith(
                        color: AppColors.onHintColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChange: (v) => _pw2 = v,
                      validator: (v) => Validators.confirmPassword(v, _pw1),
                    ),
                    SizedBox(height: 36.h),
                    Column(
                      children: [
                        const GuideLine(text: "Must be at least 8 characters"),
                        const GuideLine(
                          text:
                              "Must have special characters like * ( & \$ @ ^ !",
                        ),
                        const GuideLine(text: "Must contain numbers"),
                      ],
                    ),
                    SizedBox(height: 78.h),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return CustomButton(
                          text: isLoading
                              ? "Submitting..."
                              : "Create a new password",
                          onPressed: isLoading
                              ? () {}
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .resetPassword(
                                          email: widget.email,
                                          resetCode: widget.resetCode,
                                          newPassword: _pw1,
                                          confirmPassword: _pw2,
                                        );
                                  }
                                },
                        );
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
