import 'package:go_router/go_router.dart';
import 'package:mentor_link/root_screen.dart';
import 'package:mentor_link/src/features/authentication/presentation/screens/confirm_code_screen.dart';
import 'package:mentor_link/src/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:mentor_link/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:mentor_link/src/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:mentor_link/src/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:mentor_link/src/features/authentication/presentation/screens/success_changed_pw.dart';
import 'package:mentor_link/src/features/chatBot/presentation/screens/chat_screen.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/application_form.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/filter_screen.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/mentor_info_screen.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/payment_confirmed.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/payment_screen.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/search_screen.dart';
import 'package:mentor_link/src/features/mentors/presentation/screens/view_mentors_screen.dart';
import 'package:mentor_link/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/screens/road_map_steps.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/edit_goals.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/edit_intersets.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/edit_level.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/edit_main_info.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/edit_pace.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/edit_profile_info.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/learning_goal_screen.dart';
import 'package:mentor_link/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:mentor_link/src/features/roadMap/presentation/screens/road_map_screen.dart';

import '../../features/authentication/presentation/screens/success_create_acc.dart';
import '../../features/mentors/presentation/data/models/mentor_card_models.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

abstract class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutePaths.splashScreen,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.forgetPasswordScreen,
        builder: (context, state) {
          final email = state.extra as String?;
          return ForgetPasswordScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.successCreateAcc,
        builder: (context, state) => const SuccessCreateAcc(),
      ),
      GoRoute(
        path: AppRoutePaths.confirmCodeScreen,
        builder: (context, state) {
          final email = state.extra as String?;
          return ConfirmCodeScreen(email: email ?? '');
        },
      ),
      GoRoute(
        path: AppRoutePaths.resetPasswordScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, String>?;
          final email = data?['email'] ?? '';
          final code = data?['resetCode'] ?? '';
          return ResetPasswordScreen(email: email, resetCode: code);
        },
      ),
      GoRoute(
        path: AppRoutePaths.successChangePw,
        builder: (context, state) => const SuccessChangedPw(),
      ),
      GoRoute(
        path: AppRoutePaths.profileScreen,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.editProfileInfoScreen,
        builder: (context, state) {
          return const EditProfileInfo();
        },
      ),
      GoRoute(
        path: AppRoutePaths.editMainInfoScreen,
        builder: (context, state) {
          return const EditMainInfo();
        },
      ),
      GoRoute(
        path: AppRoutePaths.learningGoalScreen,
        builder: (context, state) {
          return const LearningGoalScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.editGoalsScreen,
        builder: (context, state) {
          return const EditGoals();
        },
      ),
      GoRoute(
        path: AppRoutePaths.editPaceScreen,
        builder: (context, state) {
          return const EditPace();
        },
      ),
      GoRoute(
        path: AppRoutePaths.editLevelScreen,
        builder: (context, state) {
          return const EditLevel();
        },
      ),
      GoRoute(
        path: AppRoutePaths.editInterestsScreen,
        builder: (context, state) {
          return const EditIntersets();
        },
      ),
      GoRoute(
        path: AppRoutePaths.rootScreen,
        builder: (context, state) {
          return const RootScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.searchScreen,
        builder: (context, state) {
          return const SearchScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.profileSetupScreen,
        builder: (context, state) => const RoadmapSteps(),
      ),
      GoRoute(
        path: AppRoutePaths.viewMentorsScreen,
        builder: (context, state) {
          return const ViewMentors();
        },
      ),
      GoRoute(
        path: AppRoutePaths.filterMentorScreen,
        builder: (context, state) {
          return const FilterScreen();
        },
      ),

      GoRoute(
        path: AppRoutePaths.mentorInfoScreen,
        builder: (context, state) {
          final mentor = state.extra as MentorModel;
          return MentorInfoScreen(mentor: mentor);
        },
      ),
      GoRoute(
        path: AppRoutePaths.applicationForm,
        builder: (context, state) {
          final mentor = state.extra as MentorModel;
          return ApplicationForm(mentor: mentor);
        },
      ),
      GoRoute(
        path: AppRoutePaths.paymentScreen,
        builder: (context, state) {
          final mentor = state.extra as MentorModel;

          return PaymentScreen(mentor: mentor);
        },
      ),
      GoRoute(
        path: AppRoutePaths.paymentConfirmed,
        builder: (context, state) {
          final mentor = state.extra as MentorModel;
          return PaymentConfirmed(mentor: mentor);
        },
      ),
      GoRoute(
        path: AppRoutePaths.chatBotScreen,
        builder: (context, state) {
          return const ChatScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.roadMapScreen,
        builder: (context, state) {
          return const RoadMapScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.roadMapSteps,
        builder: (context, state) {
          return const RoadmapSteps();
        },
      ),
    ],
  );
}

class AppRoutePaths {
  static String get splashScreen => '/';

  static String get onboardingScreen => '/onboarding';

  static String get loginScreen => '/login';

  static String get signUpScreen => '/signUp';

  static String get forgetPasswordScreen => '/forgetPassword';

  static String get successCreateAcc => '/successAcc';

  static String get successChangePw => '/changePw';

  static String get confirmCodeScreen => '/confirmCode';

  static String get resetPasswordScreen => '/resetPw';

  static String get profileScreen => '/profileScreen';

  static String get editProfileInfoScreen => '/editProfile';

  static String get editMainInfoScreen => '/editMainInfo';

  static String get learningGoalScreen => '/learningGoal';

  static String get editGoalsScreen => '/editGoals';

  static String get editPaceScreen => '/editPace';

  static String get editLevelScreen => '/editLevel';

  static String get editInterestsScreen => '/editInterests';

  static String get rootScreen => '/root';

  static String get viewMentorsScreen => '/viewMentors';

  static String get searchScreen => '/search';

  static String get filterMentorScreen => '/filterMentor';

  static String get mentorInfoScreen => '/mentorInfo';
  static String get applicationForm => '/applicationForm';
  static String get paymentScreen => '/paymentScreen';
  static String get paymentConfirmed => '/paymentConfirmed';
  static String get chatBotScreen => '/chatBot';
  static String get roadMapScreen => '/roadMapScreen';
  static String get roadMapSteps => '/roadMapSteps';

  static String get profileSetupScreen => '/profileSetupScreen';
}
