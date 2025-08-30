import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class Step3Road extends StatefulWidget {
  const Step3Road({super.key});

  @override
  State<Step3Road> createState() => _Step3RoadState();
}

class _Step3RoadState extends State<Step3Road> {
  double _days = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${_days.toInt()} days",
          style: Styles.boldTextStyle20.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'per week',
          style: Styles.textStyle16.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),

        Slider(
          value: _days,
          min: 1,
          max: 7,

          divisions: 6,
          label: "${_days.toInt()}",
          activeColor: context.colorScheme.primary,
          inactiveColor: const Color(0xFFF5FCE9),
          onChanged: (val) {
            setState(() => _days = val);
          },
        ),

        // min-max labels
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 day",
                style: Styles.textStyle12.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              Text(
                "7 days",
                style: Styles.textStyle12.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
