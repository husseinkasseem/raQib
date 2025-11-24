import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/colors%20manager.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimary
    ),
    bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.textSecondary
    ),
  ),
  );

  static ThemeData darkTheme = ThemeData(

  );
}