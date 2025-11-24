import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/colors%20manager.dart';

class CustomButton extends StatelessWidget {
  void Function() onPressed ;
  late String text ;
  CustomButton({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primary,
        ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.backgroundApp
            ),
          ),
      ),
    );
  }
}
