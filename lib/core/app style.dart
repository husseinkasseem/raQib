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
      fontSize: 30.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "cairo",
      color: ColorsManager.textPrimaryLight
    ),
    headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "cairo",
        color: ColorsManager.textPrimaryLight
    ),
    titleLarge: TextStyle(
      fontFamily: 'cairo',
      fontSize: 26.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryLight
    ),
    bodyLarge: TextStyle(
        fontFamily: "cairo",
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.textSecondaryLight
    ),
    bodySmall: TextStyle(
        fontFamily: "cairo",
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: ColorsManager.textSecondaryLight
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.primary,
      decoration: TextDecoration.underline,
      decorationColor: ColorsManager.primary,
    ),
  ),
    colorScheme: ColorScheme.light(
      primary: ColorsManager.primary,
      secondary: ColorsManager.secondary,
      onPrimary: ColorsManager.textPrimaryLight,
      onSecondary: ColorsManager.textSecondaryLight,
      error: ColorsManager.success,
      onError: ColorsManager.error,
      tertiary: ColorsManager.backgroundAppLight
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.backgroundAppDark,
    fontFamily: 'cairo',
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          fontFamily: "cairo",
          color: ColorsManager.textPrimaryDark
      ),
      headlineMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "cairo",
          color: ColorsManager.textPrimaryDark
      ),
      titleLarge: TextStyle(
          fontFamily: 'cairo',
          fontSize: 30.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.textPrimaryDark
      ),
      bodyLarge: TextStyle(
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
      error: ColorsManager.success,
      onError: ColorsManager.error,
      tertiary: ColorsManager.backgroundAppDark

    ),
  );
}