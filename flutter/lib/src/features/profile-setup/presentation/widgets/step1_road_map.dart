import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.dart';
import 'optional_tile.dart' show OptionTile;

class Step1RoadMap extends StatefulWidget {
  const Step1RoadMap({super.key});

  @override
  State<Step1RoadMap> createState() => _Step1RoadMapState();
}

class _Step1RoadMapState extends State<Step1RoadMap> {
  int selectedIndex = -1;
  final List<Map<String, String>> options = [
    {"text": "UI/UX Design", "imageUrl": Assets.figmaIcon},
    {"text": "Business Analysis", "imageUrl": Assets.businessIcon},
    {"text": "Front-End Development", "imageUrl": Assets.reactIcon},
    {"text": "Back-End Development", "imageUrl": Assets.dotNetIcon},
    {
      "text": "Data Science & Machine Learning",
      "imageUrl": Assets.pythonIcon,
    },
    {"text": "Data Analysis", "imageUrl": Assets.mySqlIcon},
  ];
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];

        return OptionTile(text: option['text']!, imageUrl: option['imageUrl']!,onTap: (){
          setState(() {
            selectedIndex = index; // update selection
          });
        }, isSelected: selectedIndex == index,);
      },
    );
  }
}
