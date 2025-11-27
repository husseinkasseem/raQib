import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/strings%20manager.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "forgot password" ;
  TextEditingController controller = TextEditingController() ;
 ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding:  REdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 36.h,),
              Image.asset(AssetsManager.logo),
              SizedBox(height: 38.h,),
              Text(
                StringsManager.forgotPassword,
              style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.h,),
              Text(
                  StringsManager.forgotPasswordSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h,),
              CustomTextField(
                  hint: StringsManager.emailOrPassword,
                  keyboardType: TextInputType.text,
                  controller: controller
              ),
              SizedBox(height: 24.h,),
              CustomButton(
                  text: StringsManager.resetPassword,
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
