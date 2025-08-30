import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../core/theming/app_styles.dart';

class ChatBotButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const ChatBotButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.h,
      width: 127.w,
      decoration: BoxDecoration(color: context.colorScheme.onPrimary,borderRadius: BorderRadius.circular(12.r),)
      ,child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,style: Styles.textStyle12.copyWith(color: const Color(0xFF08445E),),),
        SizedBox(width: 8.w,),
        Icon(icon,size: 18.sp,color: const Color(0xFF08445E),),

      ],
    ) ,
    );
  }}