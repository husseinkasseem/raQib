import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/assets manager.dart';
import '../../core/constants/colors manager.dart';
import '../../core/constants/strings manager.dart';
import '../../core/constants/constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgot password";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.primary),
          onPressed: () => Navigator.pop(context),
        ),
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
                  // جزء اللوجو مع علامة الاستفهام
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 140.h,
                        width: 140.w,
                        padding: REdgeInsets.all(10),
                        child: Image.asset(AssetsManager.logo, fit: BoxFit.contain),
                      ),
                      Positioned( // تم تصحيح الخطأ هنا
                        right: 0,
                        top: 0,
                        child: Text(
                          "؟",
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    StringsManager.forgotPassword.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    StringsManager.forgotPasswordSubtitle.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      labelText: StringsManager.email.tr(),
                      hintText: "example@gmail.com",
                      prefixIcon: Icon(Icons.email_outlined, size: 22.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: REdgeInsets.all(18),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.requiredField.tr();
                      }
                      if (!RegExp(regexEmail).hasMatch(value)) {
                        return StringsManager.invalidInput.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 35.h),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _handleResetPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55.h),
                      backgroundColor: ColorsManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      StringsManager.resetPassword.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleResetPassword() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم إرسال رابط استعادة كلمة السر لبريدك")),
      );
      if(mounted) Navigator.pop(context);
    });
  }
}