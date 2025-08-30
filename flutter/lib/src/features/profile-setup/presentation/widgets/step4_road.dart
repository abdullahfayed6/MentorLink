import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class Step4Road extends StatefulWidget {
  const Step4Road({super.key});

  @override
  State<Step4Road> createState() => _Step4RoadState();
}

class _Step4RoadState extends State<Step4Road> {
  double _hours = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${_hours.toInt()} hours",
          style: Styles.boldTextStyle20.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'per day',
          style: Styles.textStyle16.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),

        Slider(
          value: _hours,
          min: 1,
          max: 8,

          divisions: 7,
          label: "${_hours.toInt()}",
          activeColor: context.colorScheme.primary,
          inactiveColor: const Color(0xFFF5FCE9),
          onChanged: (val) {
            setState(() => _hours = val);
          },
        ),

        // min-max labels
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 hour",
                style: Styles.textStyle12.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              Text(
                "8 hours",
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
