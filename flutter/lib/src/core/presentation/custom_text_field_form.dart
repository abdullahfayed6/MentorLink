import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../theming/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.onChange,
    this.isObscure = false,
    required this.borderColor,
    this.hintStyle,
    this.prefixIconColor,
    this.suffixIcon,
    this.initialValue,
    this.fillColor,
    this.minLength = 1,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.keyboardType,
  });

  final String? hint;
  final IconData? prefixIcon;
  final void Function(String)? onChange;
  final bool isObscure;
  final Color borderColor;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;
  final Icon? suffixIcon;
  final String? initialValue;
  final Color? fillColor;
  final int? minLength;
  final TextStyle? style;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: _obscureText,
      onChanged: widget.onChange,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      validator:
          widget.validator ??
          (value) {
            if (value?.isEmpty ?? true) {
              return 'This field is required';
            }
            return null;
          },
      keyboardType: widget.keyboardType,
      style: widget.style,
      cursorColor: context.colorScheme.primary,
      minLines: widget.isObscure ? 1 : widget.minLength,
      maxLines: widget.isObscure ? 1 : null,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: widget.hintStyle,

        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: 24.sp,
                color: widget.prefixIconColor ?? AppColors.onHintColor,
              )
            : null,

        suffixIcon: widget.isObscure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.onHintColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // toggle show/hide
                  });
                },
              )
            : widget.suffixIcon,

        border: buildBorder(),
        filled: widget.fillColor != null, // only fill if color is provided
        fillColor: widget.fillColor,
        enabledBorder: buildBorder(widget.borderColor),
        focusedBorder: buildBorder(widget.borderColor),
      ),
    );
  }

  OutlineInputBorder buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
