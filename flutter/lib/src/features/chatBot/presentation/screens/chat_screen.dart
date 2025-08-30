import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_text_field_form.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/chatBot/presentation/widgets/chatbot_buttons.dart';

import '../widgets/bottom_section.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickActions = [
      {"title": "Create Image", "icon": Icons.image_outlined},
      {"title": "Make a Plane", "icon": Icons.send_outlined},
      {"title": "Data Analysis", "icon": Icons.trending_up},
      {"title": "More...", "icon": Icons.more_horiz},
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: ()=>context.pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        height: 37.h,
                        width: 146.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.primaryLight,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Plus",
                              style: Styles.textStyle16.copyWith(
                                color: const Color(0xFF40590D),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.auto_awesome,
                              color: const Color(0xFF40590D),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.menu,
                        size: 28,
                        color: context.colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                Text(
                  "How can I help you?",
                  style: Styles.boldTextStyle20.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 32.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24.w,
                  runSpacing: 12.h,
                  children: quickActions.map((item) {
                    return ChatBotButton(
                      title: item["title"],
                      icon: item["icon"],
                    );
                  }).toList(),
                ),
              ],
            ),
           const BottomChatBotSection(),
          ],
        ),
      ),
    );
  }
}

