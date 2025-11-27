import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/colors%20manager.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.backgroundAppLight,
    fontFamily: 'cairo',
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'cairo',
      fontSize: 26.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryLight
    ),
    bodyLarge: TextStyle(
        fontFamily: "cairo",
        fontSize: 16.sp,
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
        brightness: Brightness.light,
        primary: ColorsManager.primary,
        onPrimary: ColorsManager.backgroundAppLight,
        secondary: ColorsManager.secondary,
        onSecondary: ColorsManager.backgroundAppLight,
        error: ColorsManager.error,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.backgroundAppDark,
    fontFamily: 'cairo',
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'cairo',
          fontSize: 26.sp,
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
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primary,
      ),
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: ColorsManager.primary,
      onPrimary: ColorsManager.textPrimaryDark,
      secondary: ColorsManager.secondary,
      onSecondary: ColorsManager.textPrimaryDark,
      error: ColorsManager.error,
      onError: ColorsManager.backgroundAppLight,
    ),
  );
}