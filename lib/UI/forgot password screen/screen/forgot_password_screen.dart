import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/constant.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/reusable%20widgets/customDialog.dart';
import 'package:raqib/core/strings%20manager.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgot password" ;

 ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController emailController  ;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController() ;
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose() ;
    // TODO: implement dispose
    super.dispose();
  }
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 36.h,),
                  Container(
                      height: 120.h,
                      width: 120.w,
                      child: Image.asset(AssetsManager.logo)),
                  SizedBox(height: 38.h,),
                  Text(
                    StringsManager.forgotPassword.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h,),
                  Text(
                      StringsManager.forgotPasswordSubtitle.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                      validator: (value){
                          if(value==null || value.isEmpty){
                            return StringsManager.requiredField.tr();
                          }
                          if(!RegExp(regexEmail).hasMatch(value)){
                            return StringsManager.invalidInput.tr();
                          }
                      },
                      hint: StringsManager.emailOrPassword.tr(),
                      keyboardType: TextInputType.text,
                      controller: emailController
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(
                      text: StringsManager.resetPassword.tr(),
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          CustomDialog.showLoadingDialog(context);

                        }
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
