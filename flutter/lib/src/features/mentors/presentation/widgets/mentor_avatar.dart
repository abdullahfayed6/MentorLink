import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';

class MentorAvatar extends StatelessWidget {
  const MentorAvatar({super.key, required this.mentor});
final MentorModel mentor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      width: 54.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        image: DecorationImage(

          image: AssetImage(mentor.imageUrl),
          fit: BoxFit.fill,

        ),
      ),
    );
  }
}
