import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqib/UI/forgot%20password%20screen/screen/forgot_password_screen.dart';
import 'package:raqib/UI/register_screen/screen/Register_Screen.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/strings%20manager.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailOrPhoneController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;
  static const String routeName = "login screen" ;
   LoginScreen({super.key});

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
              controller: emailOrPhoneController,
              keyboardType: TextInputType.emailAddress,
              hint: StringsManager.emailOrPassword,
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
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
                    style: Theme.of(context).textTheme.bodyMedium
                  )
              ),
            ),
            SizedBox(height: 22.h,),
            CustomButton(
                text: StringsManager.login,
                onPressed: (){
            
                }
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: ColorsManager.primary,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 58),
                  child: Text(StringsManager.or,style: TextStyle(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringsManager.dontHaveAcc,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
            
                TextButton(onPressed: (){
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
                },
                    child: Text(
                      StringsManager.createOne,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                )
              ],
            ),
              SizedBox(height: 24.h,),
            ],
            ),
          ),
        ),
      ),
    );
  }
}