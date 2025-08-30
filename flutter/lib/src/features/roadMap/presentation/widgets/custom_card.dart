import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/roadMap/presentation/widgets/topic_card.dart';

class CustomCard extends StatelessWidget {
  final int dayIndex;
  const CustomCard({super.key, required this.dayIndex});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> data = [
      {
        "title": "Design Fundamentals",
        "subtitle": "Master the core principles of design",
        "progress": 0.5,
        "done": "50% Done",
        "topics": [
          {"title": "Color Theory & Typography", "active": true},
          {"title": "Layout & Composition", "active": true},
          {"title": "Visual hierarchy", "active": false},
          {"title": "Design Systems", "active": false},
        ],
      },
      {
        "title": "UI Basics",
        "subtitle": "Master user interface basics",
        "progress": 0.3,
        "done": "30% Done",
        "topics": [
          {"title": "Wireframes", "active": true},
          {"title": "Mockups", "active": false},
          {"title": "Colors & Fonts", "active": false},
        ],
      },
      {
        "title": "Prototyping",
        "subtitle": "Learn prototyping & testing",
        "progress": 0.8,
        "done": "80% Done",
        "topics": [
          {"title": "Figma Prototypes", "active": true},
          {"title": "User Testing", "active": true},
          {"title": "Feedback Loops", "active": false},
        ],
      },
    ];

    final item = data[dayIndex];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              item["done"],
              style: Styles.textStyle12.copyWith(
                color: context.colorScheme.onSecondaryContainer,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          // Progress bar
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(12.r),
            value: item["progress"],
            minHeight: 8.h,
            backgroundColor: const Color(0xFFCAD7D7),
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF7FB11B),
            ),
          ),
          SizedBox(height: 12.h),
          // Title
          Text(
            item["title"],
            style: Styles.textStyle16.copyWith(
              color: context.colorScheme.onSecondaryContainer,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item["subtitle"],
            style: Styles.textStyle12.copyWith(color: const Color(0xFF6C6C6C)),
          ),
          SizedBox(height: 12.h),
          // Topics
          for (final t in item["topics"])
            Topic(t["title"], active: t["active"]),
        ],
      ),
    );
  }
}