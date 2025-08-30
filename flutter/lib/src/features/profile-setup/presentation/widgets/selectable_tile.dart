import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

class SelectableTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableTile({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42.h,
        width: 156.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF5FCE9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:  context.colorScheme.primary,
            width: isSelected? 2:1,

          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF7FB11B),
              blurRadius: 10.r,
              spreadRadius: 5.r,
            )
          ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}