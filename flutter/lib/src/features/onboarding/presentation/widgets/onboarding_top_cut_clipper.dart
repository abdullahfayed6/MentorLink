import 'package:flutter/material.dart';

class OnboardingTopCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double topY = size.height * 0.18;
    final double peak = -size.height * 0.12;

    path.moveTo(0, topY);

    path.cubicTo(
      size.width * 0.25,
      topY + peak,
      size.width * 0.75,
      topY + peak,
      size.width,
      topY,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
