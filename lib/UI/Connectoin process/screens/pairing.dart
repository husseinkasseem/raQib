import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Connected.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/strings%20manager.dart';

class Pairing extends StatefulWidget {
  static const String routeName = "Pairing" ;
  Pairing({super.key});

  @override
  State<Pairing> createState() => _PairingState();
}

class _PairingState extends State<Pairing> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(Connected.routeName);
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
                  StringsManager.pairing,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 171.h,),
                Image.asset(AssetsManager.pairing),
                SizedBox(height: 140.h,),
                Column(
                  children: [
                    Text(StringsManager.connected,
                    style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text("OBD-11Device",
                    style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height:111.h,),
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
