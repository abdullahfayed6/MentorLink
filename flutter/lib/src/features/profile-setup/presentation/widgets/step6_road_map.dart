import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/widgets/selectable_tile.dart';

class Step6Road extends StatefulWidget {
  const Step6Road({super.key});

  @override
  State<Step6Road> createState() => _Step6RoadState();
}

class _Step6RoadState extends State<Step6Road> {
  final List<String> technologies = [
    "React",
    "Java Script",
    "Figma",
    "Angular",
    "Python",
    "Vs Code",
    "Flutter",
    "Aws",
    "JUnit",
    "Wireshark",
    "Jira",
    "Sql",
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(top: 52.h),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 16.h,
          children: List.generate(
            technologies.length,
                (index) => SelectableTile(
              text: technologies[index],
              isSelected: selectedIndex == index,
              onTap: () {
                setState(() {
                  if (selectedIndex == index) {
                    selectedIndex = -1;
                  } else {
                    selectedIndex = index;
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}