import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/header.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/widgets/custom_buttomNav.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/widgets/step6_road_map.dart';
import '../../../../../generated/assets.dart';
import '../widgets/step1_road_map.dart';
import '../widgets/step2_road.dart';
import '../widgets/step3_road.dart';
import '../widgets/step4_road.dart';
import '../widgets/step5_road_map.dart';
import '../widgets/final_roadmap.dart'; // شاشة الفاينال

class RoadmapSteps extends StatefulWidget {
  const RoadmapSteps({super.key});

  @override
  State<RoadmapSteps> createState() => _RoadmapStepsState();
}

class _RoadmapStepsState extends State<RoadmapSteps> {
  int _currentStep = 0;
  final int _totalSteps = 7; // 6 Steps + Final Screen

  final List<Map<String, String>> stepTexts = [
    {
      "title": "Choose your Track",
      "subtitle": "What field would you like to master?",
    },
    {
      "title": "What's Your Level?",
      "subtitle": "Help us understand your current\nexperience.",
    },
    {
      "title": "Weekly Commitment",
      "subtitle": "How many days per week can you dedicate to learning?",
    },
    {
      "title": "Daily Time",
      "subtitle": "How many hours can you study each day?",
    },
    {"title": "Your End Goal", "subtitle": "What are you working towards?"},
    {
      "title": "Perfect Technology",
      "subtitle": "Which technology interests you most?",
    },
    {
      "title": "", // Final screen – مفيش title
      "subtitle": "",
    },
  ];

  void nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalProgressSteps = _totalSteps - 1; // ✅ احسب لحد 6 بس
    final bool isFinalScreen = _currentStep == _totalSteps - 1;

    final double progress =
    ((_currentStep + 1) / totalProgressSteps).clamp(0.0, 1.0);
    final int percentage = (progress * 100).round();

    final bool showImage = _currentStep == 2 || _currentStep == 3;

    return Scaffold(
      appBar: Header(
        title: "Roadmap Steps",
        showDefaultLeading: _currentStep > 0,
        onTap: previousStep,
        showActionImg: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        child: Column(
          children: [
            // ✅ اعرض العناوين والـ progress bar بس لو مش آخر شاشة
            if (!isFinalScreen) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    stepTexts[_currentStep]['title']!,
                    style: Styles.textStyle20.copyWith(
                      color: const Color(0xFF68940F),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    stepTexts[_currentStep]['subtitle']!,
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              if (showImage) ...[
                SizedBox(height: 46.h),
                SvgPicture.asset(
                  _currentStep == 2 ? Assets.step3Image : Assets.onboarding3,
                ),
                SizedBox(height: 47.h),
              ],
              SizedBox(height: 15.h),

              // --- Progress Section ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Step ${_currentStep + 1} of $totalProgressSteps"),
                      Text("$percentage %"),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: progress,
                    color: const Color(0xFF7FB11B),
                    backgroundColor: const Color(0xFFF5FCE9),
                    borderRadius: BorderRadius.circular(12.r),
                    minHeight: 8.h,
                  ),
                ],
              ),
            ],

            // --- Steps Content ---
            Expanded(
              child: IndexedStack(
                index: _currentStep,
                children: const [
                  Step1RoadMap(),
                  Step2Road(),
                  Step3Road(),
                  Step4Road(),
                  Step5Road(),
                  Step6Road(),
                  FinalRoadmapScreen(),
                ],
              ),
            ),
          ],
        ),
      ),

      // --- Bottom Nav Button ---
      bottomNavigationBar: BottomNavButton(
        text: _currentStep == _totalSteps - 1
            ? "View My Roadmap"
            : "Next",
        onTap:  _currentStep == _totalSteps - 1?  ()=>context.go(AppRoutePaths.rootScreen): nextStep,
        showGradient: _currentStep == _totalSteps - 1,
        textColor: context.colorScheme.onSecondaryContainer,
        iconColor: context.colorScheme.onSecondaryContainer,
        showIcon: !(_currentStep == _totalSteps - 1),
      ),
    );
  }
}