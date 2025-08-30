import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

class BrandText extends StatelessWidget {
  const BrandText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Mentor',
            style: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w400,
              fontSize: 36.sp,
              color: context.colorScheme.onBackground,
            ),
          ),
          TextSpan(
            text: 'Link',
            style: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: 36.sp,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
