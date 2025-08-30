import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../theming/app_styles.dart';
import 'custom_text_field_form.dart';

class CustomTitleWithTextField extends StatelessWidget {
  const CustomTitleWithTextField({
    super.key,
    required this.title,
    this.hintText,
    required this.icon,
    this.isObscure = false,
    required this.borderColor,
    this.hintStyle,
    this.prefixIconColor,
    this.textStyle,
    this.suffixIcon,
    this.initialValue,
    this.onChange,
    this.validator,
    this.keyboardType,
  });
  final String title;
  final String? hintText;
  final IconData icon;
  final bool isObscure;
  final Color borderColor;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;
  final TextStyle? textStyle;
  final Icon? suffixIcon;
  final String? initialValue;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              textStyle ??
              Styles.boldTextStyle20.copyWith(
                color: context.colorScheme.primary,
              ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          initialValue: initialValue,
          hint: hintText,
          prefixIcon: icon,
          isObscure: isObscure,
          borderColor: borderColor,
          hintStyle: hintStyle,
          prefixIconColor: prefixIconColor,
          suffixIcon: suffixIcon,
          minLength: 1,
          onChange: onChange,
          validator: validator,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
