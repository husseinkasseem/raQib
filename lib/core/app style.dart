import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/colors%20manager.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.backgroundAppLight,
    fontFamily: 'cairo',
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "cairo",
      color: ColorsManager.primary
    ),
    headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "cairo",
        color: ColorsManager.textPrimaryLight
    ),
    titleLarge: TextStyle(          //title in onboarding
      fontFamily: 'cairo',
      fontSize: 30.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryLight
    ),
    bodyLarge: TextStyle(                 //subtitle in onboarding
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.textSecondaryLight
    ),
    bodySmall: TextStyle(
        fontFamily: "cairo",
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: ColorsManager.textSecondaryLight
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.primary,
      decorationColor: ColorsManager.primary,
    ),
  ),
    colorScheme: ColorScheme.light(
      primary: ColorsManager.primary,
      secondary: ColorsManager.secondary,
      onPrimary: ColorsManager.textPrimaryLight,
      onSecondary: ColorsManager.textSecondaryLight,
      error: ColorsManager.error,
      onError: ColorsManager.success,
      tertiary: ColorsManager.backgroundAppLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.backgroundAppDark,
    fontFamily: 'cairo',
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: "cairo",
          color: ColorsManager.primary
      ),
      headlineMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "cairo",
          color: ColorsManager.textPrimaryDark
      ),
      titleLarge:TextStyle(                 //title in onboarding
          fontFamily: 'cairo',
          fontSize: 30.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.textPrimaryDark
      ),
      bodyLarge: TextStyle(           //subtitle in onboarding
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textSecondaryDark
      ),
      bodySmall: TextStyle(
          fontFamily: "cairo",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          color: ColorsManager.textSecondaryDark
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.primary,
      ),
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: ColorsManager.primary,
      secondary: ColorsManager.secondary,
      onPrimary: ColorsManager.textPrimaryDark,
      onSecondary: ColorsManager.textSecondaryDark,
      error: ColorsManager.error,
      onError: ColorsManager.success,
      tertiary: ColorsManager.backgroundAppDark

    ),
  );
}