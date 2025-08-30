import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/generated/assets.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/features/splash/data/models/logo_keyframe.dart';
import 'package:mentor_link/src/features/splash/presentation/widgets/brand_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<LogoKeyframe> _frames = const [
    LogoKeyframe(
      width: 48.66412353515625,
      height: 51.983978271484375,
      angleDeg: 0,
    ),
    LogoKeyframe(
      width: 91.6068709908089,
      height: 97.96611618226802,
      angleDeg: 45,
    ),
    LogoKeyframe(
      width: 34.35114669799805,
      height: 36.69457244873047,
      angleDeg: 0,
    ),
    LogoKeyframe(
      width: 34.35111999511719,
      height: 36.69453048706055,
      angleDeg: 0,
    ),
  ];

  int _index = 0;
  Timer? _timer;

  // Stage-4 text reveal
  bool _showText = false;
  bool _textSlideIn = false;
  bool _logoSlideLeft = false;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (!mounted) return;
      setState(() {
        final int last = _frames.length - 1;
        if (_index < last) {
          _index += 1;
          if (_index == last) {
            _showText = true;
            _textSlideIn = false;
            _logoSlideLeft = true;
            Future.microtask(() {
              if (!mounted) return;
              setState(() => _textSlideIn = true);
            });
          }
        } else {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 1200), () {
            if (!mounted) return;
            GoRouter.of(context).go(AppRoutePaths.onboardingScreen);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LogoKeyframe frame = _frames[_index];
    final double turns = frame.angleDeg / 360.0;

    // Responsive sizes
    final double logoW = frame.width.w;
    final double logoH = frame.height.h;

    final double canvasHeight =
        math.max(frame.height.h, _frames[1].height.h) * 1.3;

    return Scaffold(
      body: Center(
        child: RepaintBoundary(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child: SizedBox(
              height: canvasHeight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedSlide(
                    offset: _logoSlideLeft
                        ? const Offset(-0.2, 0)
                        : Offset.zero,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 520),
                      curve: Curves.easeInOutCubic,
                      width: logoW,
                      height: logoH,
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 520),
                        curve: Curves.easeInOutCubic,
                        turns: turns,
                        child: SvgPicture.asset(
                          Assets.imagesLogo1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  if (_showText) ...[
                    SizedBox(width: 6.w),
                    AnimatedSlide(
                      offset: _textSlideIn ? Offset.zero : const Offset(0.3, 0),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                      child: AnimatedOpacity(
                        opacity: _textSlideIn ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOut,
                        child: const BrandText(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
