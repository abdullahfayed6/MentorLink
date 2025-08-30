import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../core/theming/app_styles.dart';

class ActionText extends StatelessWidget {
  const ActionText({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
          text,
          style:Styles.textStyle16.copyWith(color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: context.colorScheme.primary,
            decorationThickness: 1,)
      ),
    );
  }
}
