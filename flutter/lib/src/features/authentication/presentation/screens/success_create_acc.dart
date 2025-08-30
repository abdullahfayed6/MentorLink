import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/features/authentication/presentation/widgets/custom_success_sign.dart';

class SuccessCreateAcc extends StatelessWidget {
  const SuccessCreateAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSuccessSign(
      text: 'Your account has been\ncreated successfully!',
      // TODO change to setup profile screen
      navigateToPath: AppRoutePaths.profileSetupScreen,
      autoNavigateDelay: const Duration(seconds: 3),
    );
  }
}
