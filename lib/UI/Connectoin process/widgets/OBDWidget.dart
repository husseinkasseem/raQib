import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/colors%20manager.dart';

class OBDWidget extends StatelessWidget {
  String obdDetails ;
  String obdName ;
  OBDWidget({required this.obdDetails,required this.obdName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63.h,
      width: 298.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ?ColorsManager.textSecondaryDark
              :ColorsManager.primary,
        ),
      ),
      child: Column(
        children: [
          Text(
              obdName,
            style: TextStyle(
              fontFamily: "cairo",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
              ?ColorsManager.textPrimaryDark
              :ColorsManager.textPrimaryLight
            ),
          ),
          Text(
              obdDetails,
            style: TextStyle(
              fontFamily: "cairo",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.primary
            ),
          ),
        ],
      ),
    );
  }
}
