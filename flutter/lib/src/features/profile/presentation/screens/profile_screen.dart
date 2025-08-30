import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/presentation/custom_dialog.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/features/authentication/application/auth_cubit.dart';
import 'package:mentor_link/src/features/profile/presentation/widgets/custom_switch.dart';

import '../widgets/profile_menu_item.dart';
import '../widgets/user_info_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = false;
  bool _changeMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 33.w, right: 33.w, top: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoHeader(
                  onPressed: () {
                    context.push(AppRoutePaths.editMainInfoScreen);
                  },
                ),
                SizedBox(height: 28.h),
                ProfileMenuItem(
                  title: "Account Info",
                  requiredIcon: Icons.person,
                  onTap: () {
                    context.push(AppRoutePaths.editProfileInfoScreen);
                  },
                  showArrow: true,
                ),
                ProfileMenuItem(
                  title: "Learning Goals & Preferences",
                  requiredIcon: Icons.track_changes,
                  onTap: () {
                    ///start from here
                    context.push(AppRoutePaths.learningGoalScreen);
                  },
                  showArrow: true,
                ),
                ProfileMenuItem(
                  title: "Notification Settings",
                  requiredIcon: Icons.notifications_outlined,
                  trailing: CustomSwitch(
                    value: _notificationsEnabled,
                    onChanged: (val) {
                      _notificationsEnabled = val;
                      setState(() {});
                    },
                  ),
                ),
                ProfileMenuItem(
                  title: "Dark Mode",
                  requiredIcon: Icons.phone_android_outlined,
                  trailing: CustomSwitch(
                    value: _changeMode,
                    onChanged: (val) {
                      _changeMode = val;
                      setState(() {});
                    },
                  ),
                ),
                ProfileMenuItem(
                  title: "About App",
                  requiredIcon: Icons.info_outline,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  title: "Get Help",
                  requiredIcon: Icons.help_outline_outlined,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  title: "Log Out",
                  requiredIcon: Icons.logout_outlined,
                  onTap: () {
                    showCustomDialog(
                      context: context,
                      title:
                          'Are you sure you want to log out of your account?',
                      negativeText: "Yes, Log out",
                      positiveText: "No, I'll stay!",
                      onNegative: () {
                        BlocProvider.of<AuthCubit>(context).logout();
                        GoRouter.of(context).go(AppRoutePaths.loginScreen);
                      },
                    );
                  },
                  borderColor: AppColors.error,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
