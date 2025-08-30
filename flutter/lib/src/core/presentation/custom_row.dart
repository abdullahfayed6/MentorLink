import 'package:flutter/material.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../theming/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: Styles.textStyle22.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
