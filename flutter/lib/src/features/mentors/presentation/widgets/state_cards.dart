import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/state_card.dart';

class StateCards extends StatelessWidget {
  const StateCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 20.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StateCard(
            onTap: () {},
            text: "Reviews",
            icon: Icons.star_border_outlined,
          ),
          StateCard(
            onTap: () {},
            text: "Contact",
            icon: Icons.email_outlined,
          ),
          StateCard(onTap: () {}, text: "Share", icon: Icons.share),
        ],
      ),
    );
  }
}
