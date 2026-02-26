import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Connected.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Scanning.dart';
import 'package:raqib/UI/Connectoin%20process/screens/Select_OBD.dart';
import 'package:raqib/UI/Connectoin%20process/screens/pairing.dart';
import 'package:raqib/UI/Onboarding%20Screen/screen/onboarding_screen.dart';
import 'package:raqib/UI/forgot%20password%20screen/screen/forgot_password_screen.dart';
import 'package:raqib/UI/home%20screen/screen/home_screen.dart';
import 'package:raqib/UI/login%20screen/screen/login_screen.dart';
import 'package:raqib/core/app%20style.dart';
import 'package:raqib/core/prefs_helper.dart';
import 'package:raqib/core/themeProvider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsHelper.init() ;
  runApp(ChangeNotifierProvider(
    create: (context)=> ThemeProvider()..initTheme(),
      child: EasyLocalization(
          supportedLocales: [
            Locale('en'),
            Locale('ar')
          ],
          path: 'assets/translations',
          fallbackLocale: Locale(Intl.systemLocale),
          saveLocale: true,
          child:const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});


  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context) ;
    return ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'raQib',
            theme: AppStyle.lightTheme,
            darkTheme: AppStyle.darkTheme,
            themeMode: themeProvider.currentTheme,
            routes: {
              LoginScreen.routeName: (_) => LoginScreen(),
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              ForgotPasswordScreen.routeName:(_) => ForgotPasswordScreen(),
              Scanning.routeName:(_) => Scanning(),
              SelectOBD.routeName:(_) => SelectOBD(),
              Pairing.routeName:(_) => Pairing(),
              Connected.routeName:(_) => Connected(),
              HomeScreen.routeName:(_) => HomeScreen(),
            },
             initialRoute: PrefsHelper.getScreen()
                 ?LoginScreen.routeName
                 :OnboardingScreen.routeName,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        }
    );
  }
}