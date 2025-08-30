import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, size, size),
        );
      },
      child: Icon(
        icon,
        size: size,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}