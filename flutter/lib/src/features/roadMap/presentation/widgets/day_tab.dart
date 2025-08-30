import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayTab extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback? onTap;

  const DayTab(this.text, {super.key, this.active = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.grey[800],
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white54),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.lightGreenAccent : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}