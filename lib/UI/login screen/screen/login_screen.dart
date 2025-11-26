import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqib/UI/register_screen/screen/Register_Screen.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/strings%20manager.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login screen" ;
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: ColorsManager.backgroundApp,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
    ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: 25
          ),
          child: Column(
          children: [
          SizedBox(height: 36.h,),
          Image.asset(AssetsManager.logo),
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
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            hint: "Email",
          ),
          SizedBox(height: 16.h,),
          CustomTextField(
              hint: "Password",
            keyboardType: TextInputType.text,
            ),
          SizedBox(height: 22.h,),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: (){

                },
                child: Text(
                    "Forgot password",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorsManager.primary,
                  ),
                )
            ),
          ),
          SizedBox(height: 22.h,),
          CustomButton(
              text: "Login",
              onPressed: (){

              }
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 58),
                child: Text("Or",style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.primary
                ),),
              ),
              Expanded(
                  child: Divider(
                    color: ColorsManager.primary,
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
                      Text("Login with google",
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
                      width: 0.75,
                    )
                  )
                ),
                child: Row(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    children: [
                      SvgPicture.asset(AssetsManager.appleIcon),
                      SizedBox(width: 38.w,),
                      Text("Login with apple",
                      style: TextStyle(
                        color: ColorsManager.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp
                      ),
                      )
                    ]
                )),
          SizedBox(height: 24.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don’t have an account create one",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              TextButton(onPressed: (){
              Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
                  child: Text("Create one",
                    style: TextStyle(
                      decoration:TextDecoration.underline,
                        decorationColor: ColorsManager.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.primary
                    ),
                  )
              )
            ],
          ),
          ],
          ),
        ),
      ),
    );
  }
}