import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class GuideLine extends StatelessWidget {
  const GuideLine({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 8.w,bottom: 8.h),
      child: Row(

        children: [
          //here if the password valid should be change to icon check_circle
          Icon(Icons.check_circle_outline,size: 18.r,),
          SizedBox(width: 8.w,),
          Text(text,style: Styles.textStyle12.copyWith(color: context.colorScheme.onBackground)),

        ],
      ),
    );
  }
}
