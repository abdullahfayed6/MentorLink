import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_text_field_form.dart';
import 'package:mentor_link/src/core/presentation/guide_line.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';

class ApplicationForm2 extends StatelessWidget {
  const ApplicationForm2({super.key, required this.mentor});
  final MentorModel mentor;
  @override
  Widget build(BuildContext context) {
    List<String> guideline = [
      "Introduce yourself: Describe your background \nand professional journey",
      "State your goal: Share your aspirations and the\nsteps you’ve taken so far",
      "Express your needs: Tell Nader about the\nchallenges in pursuing your goal and the kind of\n help you’re looking for",
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Write a message to ${mentor.name.split(" ").first}:",
              style: Styles.textStyle20.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              borderColor: context.colorScheme.primary,
              minLength: 6,
              fillColor: context.colorScheme.primaryContainer,
              style: Styles.textStyle14.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "What to include in your message:",
              style: Styles.textStyle16.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            Column(
              children: List.generate(3, (index) {
                return GuideLine(text: guideline[index]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
