import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/utils/validators.dart';
import 'package:mentor_link/src/features/authentication/presentation/widgets/google_icon.dart';
import 'package:mentor_link/src/features/authentication/presentation/widgets/toggle_sign_up.dart';

import '../../../../core/presentation/custom_button.dart';
import '../../../../core/presentation/custom_title_with_textfield.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';
import '../../application/auth_cubit.dart';
import '../widgets/custom_divider.dart';
import '../widgets/sign_up_prompt.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _pw1 = '';
  String _pw2 = '';
  bool _isAgreed = false;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Sign Up"),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: (_) =>
                  GoRouter.of(context).go(AppRoutePaths.successCreateAcc),
              failure: (f) {
                log("----------------SignUpScreen: Failure - $f");
                _showError(f.toString());
              },
              orElse: () {},
            );
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 44.h),
                  CustomTitleWithTextField(
                    title: "Full Name",
                    hintText: 'Enter your Name',
                    icon: Icons.contact_mail_outlined,
                    borderColor: context.colorScheme.primary,
                    hintStyle: Styles.textStyle16.copyWith(
                      color: AppColors.onHintColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onChange: (v) => _name = v.trim(),
                    validator: (v) =>
                        Validators.requiredField(v, fieldName: 'Name'),
                  ),
                  SizedBox(height: 6.h),
                  CustomTitleWithTextField(
                    title: "Email",
                    hintText: 'Enter your Email',
                    icon: Icons.email_outlined,
                    borderColor: context.colorScheme.primary,
                    hintStyle: Styles.textStyle16.copyWith(
                      color: AppColors.onHintColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onChange: (v) => _email = v.trim(),
                    validator: Validators.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 6.h),
                  CustomTitleWithTextField(
                    title: "Phone",
                    hintText: 'Enter your Phone',
                    icon: Icons.phone,
                    borderColor: context.colorScheme.primary,
                    hintStyle: Styles.textStyle16.copyWith(
                      color: AppColors.onHintColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onChange: (v) => _phone = v.trim(),
                    validator: Validators.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 6.h),
                  CustomTitleWithTextField(
                    title: "Password",
                    hintText: 'Enter your Password',
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
                  SizedBox(height: 6.h),
                  CustomTitleWithTextField(
                    title: "Confirm Password",
                    hintText: 'Enter the password again',
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
                  SizedBox(height: 22.h),
                  ToggleSignUp(
                    onChanged: (value) {
                      setState(() => _isAgreed = value);
                    },
                  ),
                  SizedBox(height: 22.h),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return CustomButton(
                        text: isLoading ? "Creating..." : "Sign Up",
                        onPressed: !_isAgreed
                            ? null
                            : isLoading
                            ? () {}
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthCubit>().register(
                                    name: _name,
                                    email: _email,
                                    password: _pw1,
                                    confirmPassword: _pw2,
                                    phone: _phone,
                                  );
                                }
                              },
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  const CustomDivider(),
                  SizedBox(height: 10.h),
                  const GoogleIcon(),
                  SizedBox(height: 16.h),
                  SignUpPrompt(
                    onTap: () {
                      GoRouter.of(context).go(AppRoutePaths.loginScreen);
                    },
                    text1: "Already have an account? ",
                    text2: "Log in",
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
