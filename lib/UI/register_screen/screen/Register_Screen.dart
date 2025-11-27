import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqib/UI/login%20screen/screen/login_screen.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/strings%20manager.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register" ;
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool iconSwitch = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 36.h,),
                  Image.asset(AssetsManager.logo),
                  SizedBox(height: 38.h,),
                  Text(
                    StringsManager.createAccount,
                    style: Theme
                        .of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h,),
                  Text(
                    StringsManager.subtitleCreateAccount,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    keyboardType: TextInputType.name,
                    hint: StringsManager.name,
                  ),
                  SizedBox(height: 16.h,),
                  Row(
                    children: [
                      Expanded(
                        child: iconSwitch==true
                          ?CustomTextField(
                            hint: StringsManager.phoneNumber,
                            keyboardType: TextInputType.phone
                        )
                          :CustomTextField(
                           keyboardType: TextInputType.emailAddress,
                          hint: StringsManager.email,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            iconSwitch = !iconSwitch ;
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
                              colorFilter: ColorFilter.mode(ColorsManager.backgroundApp,
                                  BlendMode.srcIn
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    hint: StringsManager.password,
                  ),
                  SizedBox(height: 16.h,),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    hint: StringsManager.confirmPassword,
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(
                    text: StringsManager.createAccount,
                    onPressed: () {},
                  ),
                  SizedBox(height: 24.h,),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: ColorsManager.primary,
                          width: 0.75,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetsManager.googleIcon),
                        SizedBox(width: 38.w,),
                        Text(
                          "Sign up with Google",
                          style: TextStyle(
                            color: ColorsManager.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: ColorsManager.primary,
                          width: 0.75,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetsManager.appleIcon),
                        SizedBox(width: 38.w,),
                        Text(
                          "Sign up with Apple",
                          style: TextStyle(
                            color: ColorsManager.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: ColorsManager.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.primary,
                          ),
                        ),
                      ),
                    ],
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
}