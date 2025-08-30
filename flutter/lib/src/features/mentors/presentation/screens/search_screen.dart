import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/generated/assets.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_text_field_form.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = [
      "UI/UX Mentors",
      "Mobile Development",
      "AI Experts",
      "Marketing",
      "Career Advice",
      "Data Science",
      "Leadership",
      "Entrepreneurship",
      "Software Engineering",
      "Product Management",
      "Design Thinking",
      "Public Speaking",
      "Time Management",
      "Networking",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Search Freely",
          style: Styles.textStyle20.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(64.h),
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
                          autofocus: true,
                          focusNode: _searchFocusNode,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () =>
                            context.push(AppRoutePaths.filterMentorScreen),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Searches",
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  final search = recentSearches[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      search,
                      style: Styles.textStyle14.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    leading: Icon(
                      Icons.search,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.3,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      onPressed: () {
                        // remove search from list
                      },
                    ),
                    onTap: () {
                      // perform search action
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
