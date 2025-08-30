import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_styles.dart';

class InterestsContainer extends StatefulWidget {
  const InterestsContainer({super.key});

  @override
  State<InterestsContainer> createState() => _InterestsContainerState();
}

class _InterestsContainerState extends State<InterestsContainer> {
  ///here i 'll get intersets list from API
  final List<String> interests = [
    "Data Science",
    "Machine Learning",
    "AI",
    "Deep Learning",
    "Python",
    "Data Analysis",
    "Data Cleaning",
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: interests.map((interest) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFB4C1C1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              interest,
              style: Styles.textStyle16.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
