import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Onboarding%20Screen/screen/onboarding_screen.dart';
import 'package:raqib/UI/login%20screen/screen/login_screen.dart';
import 'package:raqib/UI/register_screen/screen/Register_Screen.dart';
import 'package:raqib/core/app%20style.dart';
import 'package:raqib/core/prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized() ;
  await PrefsHelper.init() ;
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppStyle.lightTheme,
            routes: {
              LoginScreen.routeName: (_) => LoginScreen(),
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              RegisterScreen.routeName:(_) => RegisterScreen(),
            },
            initialRoute: PrefsHelper.getScreen()
                ?LoginScreen.routeName
                :OnboardingScreen.routeName,
            debugShowCheckedModeBanner: false,
          );
        }
    );
  }
}