import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import '../../../../core/theming/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: MaterialStateProperty.all(AppColors.onPrimary),
      activeTrackColor: context.colorScheme.primary,
      inactiveTrackColor: AppColors.onHintColor,
      overlayColor: MaterialStateProperty.all(AppColors.onHintColor),
    );
  }
}