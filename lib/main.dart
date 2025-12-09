import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Connected.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Scanning.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Select_OBD.dart';
import 'package:raqib/UI/Connectoin%20process/screens/pairing.dart';
import 'package:raqib/UI/Onboarding%20Screen/screen/onboarding_screen.dart';
import 'package:raqib/UI/forgot%20password%20screen/screen/forgot_password_screen.dart';
import 'package:raqib/UI/login%20screen/screen/login_screen.dart';
import 'package:raqib/UI/register_screen/screen/Register_Screen.dart';
import 'package:raqib/core/app%20style.dart';
import 'package:raqib/core/prefs_helper.dart';

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
            themeMode: ThemeMode.light,
            routes: {
              LoginScreen.routeName: (_) => LoginScreen(),
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              RegisterScreen.routeName:(_) => RegisterScreen(),
              ForgotPasswordScreen.routeName:(_) => ForgotPasswordScreen(),
              Scanning.routeName:(_) => Scanning(),
              SelectOBD.routeName:(_) => SelectOBD(),
              Pairing.routeName:(_) => Pairing(),
              Connected.routeName:(_) => Connected(),
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