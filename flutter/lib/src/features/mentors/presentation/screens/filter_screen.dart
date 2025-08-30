import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/expandable_section.dart';
import 'package:mentor_link/src/core/presentation/header.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: "Filters"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 28.h),
            child: Column(
              children: [
                ExpandableSection(
                  title: "Track",
                  children: [
                    "AI / Data Science",
                    "UI / UX Design",
                    "Project Management",
                    "Backend Development",
                    "Frontend Development",
                    "DevOps / Cloud Engineering",
                  ],
                ),
                Divider(color: context.colorScheme.primary, thickness: 0.6),
                const ExpandableSection(title: "Job Title"),
                Divider(color: context.colorScheme.primary, thickness: 0.6),

                const ExpandableSection(title: "Company"),
                Divider(color: context.colorScheme.primary, thickness: 0.6),

                const ExpandableSection(title: "Skills"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
