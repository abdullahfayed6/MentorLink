import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/presentation/custom_bottom_navigation.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/view_mentors_screen.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:mentor_link/src/features/roadMap/presentation/screens/road_map_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 1;
  static final _screens = [
    const RoadMapScreen(),
    const ViewMentors(),
    const SizedBox.shrink(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    if (index == 2) {
      context.push(AppRoutePaths.chatBotScreen);
      return;
    }

    setState(() => _currentIndex = index);
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
