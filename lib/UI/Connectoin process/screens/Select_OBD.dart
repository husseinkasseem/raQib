import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Connectoin%20process/screens/pairing.dart';
import 'package:raqib/UI/Connectoin%20process/widgets/OBDWidget.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/strings%20manager.dart';

class SelectOBD extends StatefulWidget {
  static const String routeName = "Select OBD" ;
 SelectOBD({super.key});

  @override
  State<SelectOBD> createState() => _SelectOBDState();
}

class _SelectOBDState extends State<SelectOBD> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(Pairing.routeName);
    });
  }
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
                  StringsManager.selectOBD,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 88.h,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      OBDWidget(
                        obdName: "OBD-11 Device 1",
                        obdDetails: "001A:7D:A:7114",
                      ),
                      SizedBox(height: 56.h,),
                      OBDWidget(
                        obdName: "OBD-11 Device 1",
                        obdDetails: "001A:7D:A:7114",
                      ),
                      SizedBox(height: 56.h,),
                      OBDWidget(
                        obdName: "OBD-11 Device 1",
                        obdDetails: "001A:7D:A:7114",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 180.h,),


                CustomButton(
                    text: StringsManager.cancel,
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
