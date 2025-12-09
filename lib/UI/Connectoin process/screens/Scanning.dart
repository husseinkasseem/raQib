import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Select_OBD.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/strings%20manager.dart';

class Scanning extends StatefulWidget {
  static const String routeName = "Scanning" ;
  const Scanning({super.key});

  @override
  State<Scanning> createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(SelectOBD.routeName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Align(
      alignment: Alignment.center,
      child: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(height: 209.h,),
            Text(
              textAlign: TextAlign.center,
              StringsManager.scanning,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 88.h,),
            Image.asset(AssetsManager.scanning),
            SizedBox(height: 154.h,),
            Text(
                "Searching....",
              style: TextStyle(
                color: Theme.of(context).brightness==Brightness.dark
                    ?ColorsManager.textSecondaryDark
                    :ColorsManager.textSecondaryLight
              ),
            ),
            SizedBox(height: 56.h,),
            CustomButton(
                text: StringsManager.cancel,
                onPressed: (){

                }
            ),
            SizedBox(height: 56.h,),
          ],
        ),
      ),
    ),
    );
  }

}
