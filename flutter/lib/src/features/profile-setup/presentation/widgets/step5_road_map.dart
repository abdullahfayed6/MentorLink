import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/widgets/optional_tile.dart';
import '../../../../../generated/assets.dart';

class Step5Road extends StatefulWidget {
  const Step5Road({super.key});

  @override
  State<Step5Road> createState() => _Step5RoadState();
}

class _Step5RoadState extends State<Step5Road> {
  final List<Map<String, dynamic>> goals = [
    {"title": "Get an Internship", "icon": Assets.internImage},
    {"title": "Start Freelancing", "icon": Assets.freelancingImage},
    {"title": "Build Portfolio", "icon": Assets.portoflioImage},
    {"title": "Land a Job", "icon": Assets.landJobImage},
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final item = goals[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: OptionTile(
            showTrailing: true,
            text: item['title'],
            imageUrl: item['icon'],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
