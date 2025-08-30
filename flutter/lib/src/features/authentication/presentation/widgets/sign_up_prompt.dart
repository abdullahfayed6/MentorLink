import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({
    super.key,
    required this.onTap,
    required this.text1,
    required this.text2,
  });

  final VoidCallback onTap;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: Styles.textStyle16.copyWith(
            color: context.colorScheme.onSurface,
          ),
          children: [
            TextSpan(text: text1),
            TextSpan(
              text: text2,
              style: Styles.textStyle16.copyWith(
                color: context.colorScheme.primary,
              ),
              //here navigate to sign up page
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
