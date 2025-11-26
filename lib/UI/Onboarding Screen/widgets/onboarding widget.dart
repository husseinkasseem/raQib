import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';

class OnboardingWidget extends StatefulWidget {
   String imageInPage ;
   String title ;
   String subtitle ;
   bool is0page ;

  OnboardingWidget({
     required this.imageInPage,
     required this.title,
     required this.subtitle,
    this.is0page=false
});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 340.h,
            width: 360.w,
            widget.imageInPage
          ),
          SizedBox(height: 24.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  widget.title,
                style: TextStyle(
                  fontFamily: "cairo",
                  fontWeight: FontWeight.w500,
                  fontSize: 30.sp,
                  color: ColorsManager.textPrimary
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              SizedBox(width:  8.w,),
              Text(
                widget.is0page==false?"":"raQib",
                style: TextStyle(
                    fontFamily: "cairo",
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
                    color: ColorsManager.primary
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          Text(
            widget.subtitle,
            style: TextStyle(
                fontFamily: "cairo",
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: ColorsManager.textSecondary
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),

        ],
      ),
    );
  }
}
