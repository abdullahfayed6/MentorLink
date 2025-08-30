import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/features/authentication/presentation/widgets/custom_success_sign.dart';

class SuccessChangedPw extends StatelessWidget {
  const SuccessChangedPw({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSuccessSign(
      text: 'Your password has been \nreset successfully!',
      navigateToPath: AppRoutePaths.rootScreen,
      autoNavigateDelay: const Duration(seconds: 3),
    );
  }
}
