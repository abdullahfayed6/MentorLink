import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../generated/assets.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Assets.googleImage,
        height: 40.h,
        width: 40.w,
      ),
    );
  }
}