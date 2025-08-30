import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_button.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/presentation/custom_title_with_textfield.dart';
import 'package:mentor_link/src/core/utils/validators.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';
import '../../application/forgot_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Forgot Password"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Enter your email or phone number to \n            change your password",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 44.h),
                  CustomTitleWithTextField(
                    hintText: 'Enter your email or phone ',
                    icon: Icons.email_outlined,
                    title: 'Email or phone',
                    borderColor: context.colorScheme.primary,
                    hintStyle: Styles.textStyle16.copyWith(
                      color: AppColors.onHintColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onChange: (v) => _email = v.trim(),
                    validator: Validators.emailOrPhone,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 30.h),
                  Image.asset(
                    Assets.secuirtyPwImage,
                    height: 228.h,
                    width: 327.w,
                  ),
                  SizedBox(height: 30.h),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return CustomButton(
                        text: isLoading ? 'Sending...' : 'Verify your identity',
                        onPressed: isLoading
                            ? () {}
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<ForgotPasswordCubit>().sendCode(
                                    _email,
                                  );
                                  GoRouter.of(context).go(
                                    AppRoutePaths.confirmCodeScreen,
                                    extra: _email,
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
    );
  }
}
