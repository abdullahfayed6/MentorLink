import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../generated/assets.dart';
import '../theming/app_styles.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionPressed,
    this.topPadding = 25.0,
    this.showDefaultLeading = false,
    this.onTap, this.showActionImg = false,
  });

  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final double topPadding;
  final VoidCallback? onTap;
  final bool showDefaultLeading;
  final bool? showActionImg;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: showDefaultLeading
          ? GestureDetector(
              onTap: onTap ?? () => context.pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: context.colorScheme.onSurface,
              ),
            )
          : null,
      elevation: 0,
      title: Text(
        title,
        style: Styles.boldTextStyle24.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
      centerTitle: true,
      actions: [
        if (actionIcon != null)
          IconButton(
            icon: Icon(actionIcon, color: context.colorScheme.onSurface),
            onPressed: onActionPressed,
          ),
          if(showActionImg!= null)  Padding(
            padding:  EdgeInsets.only(right: 24.0.w),
            child: SvgPicture.asset(Assets.imagesLogo1,height: 26.h,width: 26.w,),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
