import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/strings%20manager.dart';

class Connected extends StatefulWidget {
  static const String routeName = "Connected" ;
  Connected({super.key});

  @override
  State<Connected> createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding:  REdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 209.h,),
                Text(
                  StringsManager.connected,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 161.h,),
                Image.asset(AssetsManager.connected),
                SizedBox(height: 140.h,),
                Column(
                  children: [
                    Text("OBD-11Device",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(StringsManager.nowReady,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height:111.h,),
                CustomButton(
                    text: StringsManager.startTrip,
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                ),
                SizedBox(height: 56.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
