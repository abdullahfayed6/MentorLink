import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/theming/app_styles.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isFirst;

  const SummaryRow({required this.title, required this.value,  this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              title,
              style: Styles.textStyle16.copyWith(color: context.colorScheme.onSurface)
          ),
          isFirst?Row(
            children: [
              SvgPicture.asset(Assets.figmaIcon,),
              SizedBox(width: 8.w,),
              Text(
                  value,
                  style: Styles.textStyle16.copyWith(color: context.colorScheme.primary)
              ),

            ],
          ):Text(
              value,
              style: Styles.textStyle16.copyWith(color: context.colorScheme.primary)
          ) ,

        ],
      ),
    );
  }
}
