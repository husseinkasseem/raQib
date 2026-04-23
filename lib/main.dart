import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:raqib/UI/Connectoin%20process/Connected.dart';
import 'package:raqib/UI/Connectoin%20process/Scanning.dart';
import 'UI/Auth/forgot_password_screen.dart';
import 'UI/Connectoin process/Select_OBD.dart';
import 'UI/Connectoin process/pairing.dart';
import 'UI/Home/home_screen.dart';
import 'UI/Onboarding Screen/onboarding_screen.dart';
import 'UI/Auth/login_screen.dart';
import 'core/themes/themeProvider.dart';
import 'core/utils/prefs_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  bool isSeen = await PrefsHelper.getScreen();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MyApp(isSeen: isSeen),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isSeen;
  const MyApp({super.key, required this.isSeen});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RaQib',
          themeMode: themeProvider.currentTheme,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: isSeen ? LoginScreen() : const OnboardingScreen(),
          routes: {
            OnboardingScreen.routeName: (context) => const OnboardingScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            Scanning.routeName: (context) => const Scanning(),
            SelectOBD.routeName: (context) => const SelectOBD(),
            ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
            Pairing.routeName: (context) => const Pairing(),
            Connected.routeName: (context) => const Connected(),
            HomeScreen.routeName: (context) => const HomeScreen(),
          },
          initialRoute: SelectOBD.routeName,

          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}