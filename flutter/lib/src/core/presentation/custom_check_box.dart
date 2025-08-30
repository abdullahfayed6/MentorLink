import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.onChanged,
    this.initialValue = false,
    required this.text,
    this.haveSize,
  });

  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final String text;
  final bool? haveSize;
  @override
  State<CustomCheckBox> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomCheckBox> {
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
    return Row(
      children: [
        Checkbox(value: _isSelected, onChanged: (val) => _toggleCheck()),
        SizedBox(width: 8.w),
        Text(widget.text, style: Styles.textStyle16),
      ],
    );
  }
}
