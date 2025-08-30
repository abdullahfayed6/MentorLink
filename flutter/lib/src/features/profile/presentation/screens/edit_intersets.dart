import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/features/profile/presentation/widgets/custom_select_wrap.dart';

import '../../../../core/theming/app_styles.dart';

class EditIntersets extends StatefulWidget {
  const EditIntersets({super.key});

  @override
  State<EditIntersets> createState() => _EditIntersetsState();
}

class _EditIntersetsState extends State<EditIntersets> {
  List<String> learningTopics = [
    "Data Science",
    "Design Thinking",
    "Machine Learning",
    "AI",
    "Database",
    "Deep Learning",
    "Networks",
    "Clean code",
    "Data Cleaning",
    "Programming",
    "Problem Solving",
    "Data Analysis",
    "Algorithms",
    "Data Structures",
    "Linear Algebra",
    "Probability & Statistical Distributions",
  ];
  List<String> preferredLanguages = [
    "HTML",
    "SQL",
    "CSS",
    "Python",
    "C#",
    "C++",
    "JavaScript",
    "PHP",
  ];

  Set<String> selectedLanguage = {};
  Set<String> selectedTopics = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Interests"),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36.h),
              Text(
                "Choose what you’d like to learn",
                style: Styles.textStyle16.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 20.h),
              CustomSelectableWrap(
                items: learningTopics,
                selectedItems: selectedTopics,
                onSelected: (String p1) {
                  setState(() {
                    if (selectedTopics.contains(p1)) {
                      selectedTopics.remove(p1);
                    } else {
                      selectedTopics.add(p1);
                    }
                  });
                },
              ),
              SizedBox(height: 36.h),
              Text(
                "Choose preferred languages or frameworks",
                style: Styles.textStyle16,
              ),
              SizedBox(height: 20.h),
              CustomSelectableWrap(
                items: preferredLanguages,
                selectedItems: selectedLanguage,
                onSelected: (p2) {
                  setState(() {
                    if (selectedLanguage.contains(p2)) {
                      selectedLanguage.remove(p2);
                    } else {
                      selectedLanguage.add(p2);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
