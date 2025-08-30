import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/plan_option_card.dart';

class ApplicationForm3 extends StatefulWidget {
  const ApplicationForm3({super.key, required this.mentor});
  final MentorModel mentor;

  @override
  State<ApplicationForm3> createState() => _ApplicationForm3State();
}

class _ApplicationForm3State extends State<ApplicationForm3> {
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose a plan:",
            style: Styles.textStyle20.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            "You will get a 7-day free trial with ${widget.mentor.name.split(" ").first} before you start paying.",
            style: Styles.textStyle16.copyWith(color: context.colorScheme.onSurface),
          ),

          SizedBox(height: 20.h),

          PlanOptionCard(
            title: "Standard Plan",
            description: const [
              "This plan has a monthly fee of 3,000 EGP / Month",
              "It includes 2 video calls per month, and 4 times Q&A via Email."
            ],
            isSelected: selectedPlan == "Standard Plan",
            onTap: () {
              setState(() {
                selectedPlan = "Standard Plan";
              });
            },
          ),

          SizedBox(height: 20.h),

          PlanOptionCard(
            title: "Premium Plan",
            description: const [
              "This plan has a monthly fee of 5,000 EGP / Month",
              "It includes weekly video calls and unlimited Q&A."
            ],
            isSelected: selectedPlan == "Premium Plan",
            onTap: () {
              setState(() {
                selectedPlan = "Premium Plan";
              });
            },
          ),
        ],
      ),
    );
  }
}