import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class ToggleSignUp extends StatefulWidget {
  const ToggleSignUp({
    super.key,
    required this.onChanged,
    this.initialValue = false,
  });

  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  @override
  State<ToggleSignUp> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<ToggleSignUp> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initialValue;
  }

  void _toggleCheck() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onChanged?.call(_isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheck,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(value: _isSelected, onChanged: (val) => _toggleCheck()),
          SizedBox(width: 8.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Styles.textStyle14.copyWith(
                  color: context.colorScheme.onSurface,
                ),
                children: [
                  const TextSpan(text: "I agree to your "),
                  TextSpan(
                    text: "privacy policy",
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "terms & conditions",
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
