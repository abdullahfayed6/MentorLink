import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/roadMap/presentation/widgets/custom_card.dart';
import '../widgets/day_tab.dart';
import '../widgets/prograss_indicator.dart';

class RoadMapScreen extends StatefulWidget {
  const RoadMapScreen({super.key});

  @override
  State<RoadMapScreen> createState() => _RoadMapScreenState();
}

class _RoadMapScreenState extends State<RoadMapScreen> {
  int selectedDay = 0;

  void _onDaySelected(int i) {
    setState(() {
      selectedDay = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 27.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey, Mohamed!👋",
              style: Styles.textStyle20.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 27.h),

            Center(child: GradientCircularProgress(progress: 0.75)),

            SizedBox(height: 27.h),

            Text(
              "Week 6",
              style: Styles.textStyle20.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            Divider(endIndent: 250.w, color: context.colorScheme.primary),
            Row(
              children: [
                DayTab(
                  "Day 1",
                  active: selectedDay == 0,
                  onTap: () => _onDaySelected(0),
                ),
                SizedBox(width: 8.w),
                DayTab(
                  "Day 2",
                  active: selectedDay == 1,
                  onTap: () => _onDaySelected(1),
                ),
                SizedBox(width: 8.w),
                DayTab(
                  "Day 3",
                  active: selectedDay == 2,
                  onTap: () => _onDaySelected(2),
                ),
              ],
            ),
            SizedBox(height: 28.h),

            CustomCard(dayIndex: selectedDay),
          ],
        ),
      ),
    );
  }
}