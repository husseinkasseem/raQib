import 'dart:ffi';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Scanning.dart';
import 'package:raqib/UI/forgot%20password%20screen/screen/forgot_password_screen.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/constant.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/reusable%20widgets/CustomTextField.dart';
import 'package:raqib/core/reusable%20widgets/customDialog.dart';
import 'package:raqib/core/strings%20manager.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login screen" ;
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          padding: REdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 36.h,),
                  Container(
                      height: 120.h,
                      width: 120.w,
                      child: Image.asset(AssetsManager.logo)),
                  SizedBox(height: 38.h,),
                  Text(
                    StringsManager.login.tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  SizedBox(height: 16.h,),
                  Text(
                    StringsManager.welcomeBack.tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.requiredField.tr();
                      }
                      if (!RegExp(regexEmail).hasMatch(value)) {
                        return StringsManager.invalidInput.tr();
                      }
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: StringsManager.email.tr(),
                  ),
                  SizedBox(height: 16.h,),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.passwordEmpty.tr();
                      }
                      if (value.length < 8 && !RegExp(regexPassword).hasMatch(
                          value)) {
                        return StringsManager.passwordWeak.tr();
                      }
                    },
                    isObscureText: true,
                    controller: passwordController,
                    hint: StringsManager.password.tr(),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 22.h,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              ForgotPasswordScreen.routeName);
                        },
                        child: Text(
                            StringsManager.forgot.tr(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsManager.primary,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 22.h,),
                  CustomButton(
                      text: StringsManager.login.tr(),
                      onPressed: () {
                        login();
                      }
                  ),
                  SizedBox(height: 16.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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

  login() async {
    if (formKey.currentState!.validate()) {
      CustomDialog.showLoadingDialog(context);
    }
  }
}