import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raqib/UI/Auth/forgot_password_screen.dart';
import '../../Service/api_service.dart';
import '../../core/constants/assets manager.dart';
import '../../core/constants/colors manager.dart';
import '../../core/constants/strings manager.dart';
import '../Connectoin process/Scanning.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false; // لإظهار وإخفاء الباسورد

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // شلنا القيم الافتراضية من هنا عشان متبقاش مكتوبة جوه الخانة
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: REdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // اللوجو بشكل ريسبونسيف
                  Image.asset(
                    AssetsManager.logo,
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    StringsManager.login.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    StringsManager.welcomeBack.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 35.h),

                  // خانة الايميل
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 15.sp),
                    decoration: InputDecoration(
                      hintText: "example@gmail.com", // الهينت اللي كان بيظهر كقيمة
                      labelText: StringsManager.email.tr(),
                      prefixIcon: Icon(Icons.email_outlined, size: 22.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: REdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return StringsManager.requiredField.tr();
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  // خانة الباسورد
                  TextFormField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    style: TextStyle(fontSize: 15.sp),
                    decoration: InputDecoration(
                      hintText: "******",
                      labelText: StringsManager.password.tr(),
                      prefixIcon: Icon(Icons.lock_outline, size: 22.sp),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          size: 20.sp,
                        ),
                        onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: REdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return StringsManager.requiredField.tr();
                      return null;
                    },
                  ),

                  // نسيت كلمة السر
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        StringsManager.forgot.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorsManager.primary,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // زرار تسجيل الدخول
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 52.h),
                      backgroundColor: ColorsManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      StringsManager.login.tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      var response = await ApiManager.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (mounted && Navigator.canPop(context)) Navigator.pop(context);

      if (response['ok'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response['token'] ?? '');
        await prefs.setString('user_name', response['employee']?['name'] ?? "");
        await prefs.setString('user_image', response['employee']?['image'] ?? "");

        await prefs.setInt('employee_id', response['employee']?['id'] ?? 0);

        if (mounted) {
          Navigator.of(context).pushReplacementNamed(Scanning.routeName);
        }
      }else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message'] ?? "بيانات الدخول غير صحيحة"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted && Navigator.canPop(context)) Navigator.pop(context);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(StringsManager.invalidInput.tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}