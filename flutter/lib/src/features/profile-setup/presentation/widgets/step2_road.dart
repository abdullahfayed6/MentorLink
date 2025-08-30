import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/widgets/levelTile.dart';

class Step2Road extends StatefulWidget {
  const Step2Road({super.key});

  @override
  State<Step2Road> createState() => _Step2RoadState();
}

class _Step2RoadState extends State<Step2Road> {
  int selectedIndex = -1;

  final List<Map<String, String>> levels = [
    {
      "title": "Junior",
      "subtitle": "New to track",
    },
    {
      "title": "Mid Level",
      "subtitle": "Some experience",
    },
    {
      "title": "Senior",
      "subtitle": "Experience developer",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( top: 64.h),
      child: Column(
        children: List.generate(

            levels.length, (index) {
          final item = levels[index];
          return LevelTile(
            title: item['title']!,
            subTitle: item['subtitle']!,
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        }),
      ),
    );
  }
}