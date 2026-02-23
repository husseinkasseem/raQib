import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Scanning.dart';
import 'package:raqib/UI/forgot%20password%20screen/screen/forgot_password_screen.dart';
import 'package:raqib/UI/register_screen/screen/Register_Screen.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/constant.dart';
import 'package:raqib/core/firebase%20handler.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/strings%20manager.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login screen" ;
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseHandler firebaseHandler = FirebaseHandler();
  late TextEditingController emailController ;
  late TextEditingController passwordController ;
  late TextEditingController phoneNumberController ;
  late TextEditingController otbController ;
  bool iconSwitch = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController() ;
    passwordController = TextEditingController() ;
    phoneNumberController = TextEditingController() ;
    otbController = TextEditingController() ;
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    otbController.dispose();
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
          padding: REdgeInsets.symmetric(
            horizontal: 25
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
              children: [
              SizedBox(height: 36.h,),
              Container(
                height: 120.h,
                width: 120.w,
                  child: Image.asset(AssetsManager.logo)),
              SizedBox(height: 38.h,),
              Text(
                StringsManager.login,
              style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.h,),
              Text(
                  StringsManager.welcomeBack,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 24.h,),
                Row(
                  children: [
                    Expanded(
                      child: iconSwitch == true
                          ?CustomTextField(
                          validator: (value){

                          },
                          controller: phoneNumberController,
                          hint: StringsManager.phoneNumber,
                          keyboardType: TextInputType.phone
                      )
                          :CustomTextField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "This field is required" ;
                          }
                        if(!RegExp(regexEmail).hasMatch(value)){
                          return "The input is not valid" ;
                        }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: StringsManager.email,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          setState(() {
                            iconSwitch = !iconSwitch ;
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorsManager.primary,
                            borderRadius: BorderRadius.circular(4.r)
              
                        ),
                        height: 40.h,
                        width: 40.w,
                        alignment: Alignment.centerRight,
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            iconSwitch==true
                                ?AssetsManager.emailIcon
                                :AssetsManager.numPadIcon,
                            colorFilter: ColorFilter.mode(
                                ColorsManager.backgroundAppLight,
                                BlendMode.srcIn
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16.h,),
              iconSwitch==true
              ?(SizedBox.shrink())
              :CustomTextField(
                validator: (value){
              
                },
                isObscureText: true,
                controller: passwordController,
                  hint: StringsManager.password,
                keyboardType: TextInputType.text,
                ),
              SizedBox(height: 22.h,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: (){
                    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                    },
                    child: Text(
                        StringsManager.forgot,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primary,
                      )
                    )
                ),
              ),
              SizedBox(height: 22.h,),
              CustomButton(
                  text: StringsManager.login,
                  onPressed: () {

                  }
                    ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color:Theme.of(context).brightness == Brightness.dark
                          ?ColorsManager.textSecondaryDark
                          :ColorsManager.primary,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 58),
                    child: Text(
                      StringsManager.or,
                      style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ?ColorsManager.textSecondaryDark
                          :ColorsManager.primary,
                    ),),
                  ),
                  Expanded(
                      child: Divider(
                        color:
                        Theme.of(context).brightness == Brightness.dark
                            ?ColorsManager.textSecondaryDark
                            :ColorsManager.primary,
                        thickness: 1,
                      )),
              
                ],
              ),
              SizedBox(height: 24.h,),
              ElevatedButton(
                   onPressed: (){
              
                   },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        side: BorderSide(
                          color: ColorsManager.primary,
                          width: 0.75,
                        )
                      )
                    ),
                    child: Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          SvgPicture.asset(AssetsManager.googleIcon),
                          SizedBox(width: 38.w,),
                          Text(
                            StringsManager.loginWithGoogle,
                          style: TextStyle(
                            color: ColorsManager.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp
                          ),
                          )
                        ]
                    )),
              SizedBox(height: 8.h,),
              ElevatedButton(
                    onPressed: (){
              
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        side: BorderSide(
                          color: ColorsManager.primary,
                          width: 0.75.w,
                        )
                      )
                    ),
                    child: Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          Theme.of(context).brightness == Brightness.light
                          ?SvgPicture.asset(
                              AssetsManager.appleIcon
                          )
                          :SvgPicture.asset(
                              AssetsManager.appleIcon,
                              colorFilter: ColorFilter.mode(
                                  ColorsManager.primary, BlendMode.srcIn
                              ),
                          ),
                          SizedBox(width: 38.w,),
                          Text(
                            StringsManager.loginWithApple,
                          style: TextStyle(
                            color: ColorsManager.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp
                          ),
                          )
                        ]
                    )),
              SizedBox(height: 24.h,),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAcc,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                        onPressed: (){
                    Navigator.of(context).pushReplacementNamed(
                        RegisterScreen.routeName);
                    },
                        child: Text(
                          StringsManager.createOne,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: ColorsManager.primary,
                          ),
                        )
                    )
                  ],
                ),
              ),
                SizedBox(height: 24.h,),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _goNext(BuildContext context) async {
    bool exists = await firebaseHandler.isUserExistsInFirestore();

    if (exists) {
      Navigator.pushReplacementNamed(context, Scanning.routeName);
    } else {
      Navigator.pushReplacementNamed(
          context, RegisterScreen.routeName);
    }
  }

}