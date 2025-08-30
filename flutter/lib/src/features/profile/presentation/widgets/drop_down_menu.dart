import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class CareerDropdown extends StatefulWidget {
  const CareerDropdown({super.key});

  @override
  State<CareerDropdown> createState() => _CareerDropdownState();
}

class _CareerDropdownState extends State<CareerDropdown> {
  String selectedCareer = "Data Science";


  final List<String> careers = [
    "Data Science",
    "UI / UX Design",
    "DevOps / Cloud Engineering",
    "Backend Development",
    "Frontend Development",
    "Project Management",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          "Your Chosen Career",
          style: Styles.textStyle16.copyWith(color: context.colorScheme.primary)
        ),
         SizedBox(height: 8.h),

        // DropdownField
        DropdownButtonFormField<String>(
          value: selectedCareer,
          items: careers.map((career) {
            return DropdownMenuItem(
              value: career,
              child: Text(
                career,
                style: Styles.textStyle14,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCareer = value!;
            });
          },
          decoration: InputDecoration(
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(color: context.colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 2,
              ),
            ),
          ),

          icon: Icon(Icons.keyboard_arrow_down_outlined, color: context.colorScheme.primary),
        ),
      ],
    );
  }
}