import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/features/onboarding/domain/onboarding_item.dart';
import 'package:mentor_link/src/features/onboarding/presentation/widgets/onboarding_top_cut_clipper.dart';
import 'package:mentor_link/src/features/onboarding/presentation/widgets/progress_ring_button.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoTimer;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      asset: Assets.onboarding1,
      title: 'Welcome to MentorLink',
      subtitle:
          'Your journey to growth starts here, connect with mentors who guide your path.',
      highlight: 'Link',
    ),
    OnboardingItem(
      asset: Assets.onboarding2,
      title: 'Connect with Experienced Mentors',
      subtitle: 'Get guidance from professionals in your field of interest',
      highlight: 'Experienced Mentors',
    ),
    OnboardingItem(
      asset: Assets.onboarding3,
      title: 'AI-Powered Learning Roadmaps',
      subtitle:
          'Tell us your goals and we’ll design a step-by-step plan just for you',
      highlight: 'AI-Powered',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  void _startAutoAdvance() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      if (_currentPage < _items.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      } else {
        _autoTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height * 0.5;
    final double panelHeight = size.height * 0.58;
    final double ringDiameter = 90.r;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: pageHeight,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _items.length,
                  onPageChanged: (i) {
                    setState(() => _currentPage = i);
                    if (i == _items.length - 1) {
                      _autoTimer?.cancel();

                    }
                  },
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal: 24.0.w,
                        vertical: 12.0.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              item.asset,
                              fit: BoxFit.contain,
                            ),
                          ),
                           SizedBox(height: 8.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _items.length,
                              (dotIndex) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin:  EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                ),
                                height: 6.h,
                                width: _currentPage == dotIndex ? 16.w : 6.w,
                                decoration: BoxDecoration(
                                  color: _currentPage == dotIndex
                                      ? Colors.black87
                                      : Colors.black26,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: OnboardingTopCutClipper(),
                child: Container(
                  height: panelHeight,
                  width: double.infinity,
                  color: const Color(0xFF1E1E1E),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      32.h,
                      24.w,
                      ringDiameter / 2 + 16.r,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 480),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text.rich(
                                  _buildTitleSpan(
                                    _items[_currentPage].title,
                                    _items[_currentPage].highlight,
                                    baseColor: Colors.white,
                                    highlightColor:  AppColors.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 24.h),
                                Text(
                                  _items[_currentPage].subtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 24.h),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: ProgressRingButton(
                              totalSegments: _items.length,
                              activeSegments: _currentPage + 1,
                              onPressed: () {
                                if (_currentPage < _items.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  GoRouter.of(context).go(AppRoutePaths.loginScreen);
                                }
                              },
                            ),
                          ),
                        ),

                        if (_currentPage < _items.length - 1)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: TextButton(
                              onPressed: () {
                                GoRouter.of(context).go(AppRoutePaths.loginScreen);
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InlineSpan _buildTitleSpan(
    String title,
    String? highlight, {
    required Color baseColor,
    required Color highlightColor,
  }) {
    final TextStyle base = TextStyle(
      fontFamily: 'Metropolis',
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
    ).copyWith(color: baseColor);

    final TextStyle bold = TextStyle(
      fontFamily: 'Metropolis',
      fontWeight: FontWeight.w700,
      fontSize: 24.sp,
    ).copyWith(color: highlightColor);

    if (highlight == null || highlight.isEmpty) {
      return TextSpan(text: title, style: base);
    }

    final int index = title.indexOf(highlight);
    if (index < 0) {
      return TextSpan(text: title, style: base);
    }

    final String before = title.substring(0, index);
    final String matched = title.substring(index, index + highlight.length);
    final String after = title.substring(index + highlight.length);

    return TextSpan(
      children: [
        if (before.isNotEmpty) TextSpan(text: before, style: base),
        TextSpan(text: matched, style: bold),
        if (after.isNotEmpty) TextSpan(text: after, style: base),
      ],
    );
  }
}
