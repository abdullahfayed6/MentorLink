import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_styles.dart';
import 'app_values.dart';

class AppTheme {
  static const double _defaultRadius = 12.0;

  static ThemeData _buildTheme(ColorScheme scheme, Color scaffoldBg) {
    final radius = BorderRadius.circular(_defaultRadius.r);
    return ThemeData(
      brightness: scheme.brightness,
      primaryColor: scheme.primary,
      scaffoldBackgroundColor: scaffoldBg,
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: Styles.fontFamily,
      appBarTheme: _appBarTheme(scheme),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: scheme.surface,
        borderColor: scheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radius),

          textStyle: TextStyle(fontFamily: Styles.fontFamily),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: radius),
        buttonColor: scheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: TextStyle(fontFamily: Styles.fontFamily),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radius),
          side: BorderSide(color: scheme.primary),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: radius),
        horizontalTitleGap: AppPadding.p12.w,
      ),
      textTheme: TextTheme(
        titleLarge: Styles.textStyle18.copyWith(color: scheme.onSurface),
        bodyMedium: Styles.textStyle14.copyWith(
          color: scheme.onSurface.withOpacity(0.8),
        ),
      ),
    );
  }

  static ThemeData get lightTheme =>
      _buildTheme(_lightColorScheme, AppColors.lightScaffoldBackgroundColor);
  static ThemeData get darkTheme =>
      _buildTheme(_darkColorScheme, AppColors.darkScaffoldBackgroundColor);

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryFixed,
    onPrimaryContainer: AppColors.onPrimaryFixed,
    onPrimary: AppColors.onPrimary,
    surface: AppColors.darkSurface,
    onSurface: AppColors.onSurfaceDark,
    error: AppColors.error,
    onError: AppColors.onError,
    onBackground: AppColors.onBackgroundDark,
    background: AppColors.darkBackground,
  );
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryFixed,
    onPrimaryContainer: AppColors.onPrimaryFixed,

    onPrimary: AppColors.onPrimary,
    surface: AppColors.lightSurface,
    onSurface: AppColors.onSurfaceLight,
    error: AppColors.error,
    onError: AppColors.onError,
    onBackground: AppColors.onBackgroundLight,
    background: AppColors.lightBackground,
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.primaryContainer,
      titleTextStyle: Styles.textStyle22.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
        fontFamily: Styles.fontFamily,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
  }) {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppPadding.p16.w,
        vertical: AppPadding.p14.h,
      ),
      errorMaxLines: 2,
      errorStyle: TextStyle(
        color: AppColors.error.withAlpha(180),
        fontSize: 12.sp,
        overflow: TextOverflow.ellipsis,
      ),
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      labelStyle: Styles.textStyle12.copyWith(
        color: fillColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
      ),
      hintStyle: Styles.textStyle12.copyWith(
        color: fillColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
      ),
    );
  }
}
