import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/di/injection.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_theme.dart';
import 'package:mentor_link/src/features/authentication/application/auth_cubit.dart';
import 'package:mentor_link/src/features/authentication/application/forgot_password_cubit.dart';

class MentorLinkApp extends StatelessWidget {
  const MentorLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (_) => getIt<AuthCubit>()),
          BlocProvider<ForgotPasswordCubit>(
            create: (_) => getIt<ForgotPasswordCubit>(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRoutes.router,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
