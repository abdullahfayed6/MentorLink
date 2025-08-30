import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../core/theming/app_styles.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({super.key, required this.onPressed});
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40.r,
              child: Image.asset(
                "assets/images/default_profile_image.png",
                height: 80.h,
                width: 80.h,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ahmed Karim", style: Styles.boldTextStyle20),
                Text("Data Scientist", style: Styles.textStyle16),
              ],
            ),
          ],
        ),
         IconButton(onPressed: onPressed, icon: Icon(Icons.edit_outlined,color: context.colorScheme.primary,))
        ,
      ],
    );
  }
}
