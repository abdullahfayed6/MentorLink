import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_text_field_form.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

import '../../../../../generated/assets.dart';
import '../data/models/mentor_card_models.dart';
import '../widgets/mentor_card.dart';

class ViewMentors extends StatelessWidget {
  const ViewMentors({super.key});

  @override
  Widget build(BuildContext context) {
    //Dummy data for test
    final mentors = [
      MentorModel(
        imageUrl: "assets/images/test_mentor_2.png",
        name: "Nader Ali",
        badge: Assets.microsoftLogo,
        rating: 4.5,
        reviewsCount: 23,
        jobTitle: "UX Researcher at Microsoft",
        jobDescription:
            "As a senior user researcher with over 15 years of experience running international research projects for global companies such as PlayStation, Spotify, and in the finance industry, I have developed a keen eye for what makes a successful UX researcher. Through my experience as a mentor, I have helped many researchers develop their generative and evaluative research skills and land their first job in the UX industry.",
        hourlyRate: 800,
        benefit: ["Fast Responder"],
        skills: [
          "UI / UX",
          "CV Review",
          "Survey",
          "Analysis",
          "UX Process",
          "Research",
        ],
      ),
      MentorModel(
        imageUrl: "assets/images/mentor_image_test2.png",
        name: "Samy Ahmed",
        badge: Assets.eBadge,
        rating: 4.8,
        reviewsCount: 40,
        jobTitle: "Product Designer at Google",
        jobDescription:
            "As a senior user researcher with over 15 years of experience running international research projects for global companies such as PlayStation, Spotify, and in the finance industry, I have developed a keen eye for what makes a successful UX researcher. Through my experience as a mentor, I have helped many researchers develop their generative and evaluative research skills and land their first job in the UX industry.",
        hourlyRate: 1200,
        benefit: ["Top Mentor"],
        skills: [
          "UI / UX",
          "CV Review",
          "Survey",
          "Analysis",
          "UX Process",
          "Research",
        ],
      ),
      MentorModel(
        imageUrl: "assets/images/test_mentor_2.png",
        name: "Nader Ali",
        badge: Assets.microsoftLogo,
        rating: 4.5,
        reviewsCount: 23,
        jobTitle: "UX Researcher at Microsoft",
        jobDescription:
            "As a senior user researcher with over 15 years of experience running international research projects for global companies such as PlayStation, Spotify, and in the finance industry, I have developed a keen eye for what makes a successful UX researcher. Through my experience as a mentor, I have helped many researchers develop their generative and evaluative research skills and land their first job in the UX industry.",
        hourlyRate: 800,
        benefit: ["Fast Responder"],
        skills: [
          "UI / UX",
          "CV Review",
          "Survey",
          "Analysis",
          "UX Process",
          "Research",
        ],
      ),
      MentorModel(
        imageUrl: "assets/images/mentor_image_test2.png",
        name: "Samy Ahmed",
        badge: Assets.eBadge,
        rating: 4.8,
        reviewsCount: 40,
        jobTitle: "Product Designer at Google",
        jobDescription:
            "As a senior user researcher with over 15 years of experience running international research projects for global companies such as PlayStation, Spotify, and in the finance industry, I have developed a keen eye for what makes a successful UX researcher. Through my experience as a mentor, I have helped many researchers develop their generative and evaluative research skills and land their first job in the UX industry.",
        hourlyRate: 1200,
        benefit: ["Fast Responder", "Top mentor"],
        skills: [
          "UI / UX",
          "CV Review",
          "Survey",
          "Analysis",
          "UX Process",
          "Research",
        ],
      ),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 40.0),
        child: Container(
          padding: EdgeInsets.only(top: kToolbarHeight + 8),
          child: Hero(
            tag: 'search-bar',
            transitionOnUserGestures: true,
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomTextField(
                          prefixIcon: Icons.search_rounded,
                          borderColor: context.colorScheme.primary,
                          fillColor: context.colorScheme.onPrimary,
                          hint: 'Search mentors...',
                          hintStyle: Styles.textStyle16.copyWith(
                            color: AppColors.onHintColor.withValues(alpha: 0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          readOnly: true,
                          onTap: () => context.push(AppRoutePaths.searchScreen),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => context.push(AppRoutePaths.searchScreen),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            Assets.filterIcon,
                            height: 20.h,
                            width: 20.w,
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 128.h),
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          final mentor = mentors[index];
          return GestureDetector(
            onTap: () {
              context.push(AppRoutePaths.mentorInfoScreen, extra: mentor);
            },
            child: MentorCard(mentorModel: mentor),
          );
        },
      ),
    );
  }
}
