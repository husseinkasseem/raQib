import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/assets manager.dart';
import '../../core/constants/colors manager.dart';
import '../../core/constants/strings manager.dart';
import '../../core/themes/themeProvider.dart';
import '../../core/utils/prefs_helper.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;
  String? selectedTheme = "light";
  String? selectedLanguage = "en";

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    List<Widget> pagesList = [
      // Page 0 - Theme & Language selection (First Position)
      Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Image.asset(
              AssetsManager.onboardingCard5.tr(),
              height: 240.h, // تقليل الارتفاع عشان الصفحة تكفي
              width: 260.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    StringsManager.titleOnboarding5.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  StringsManager.raQib.tr(),
                  style: TextStyle(
                    fontFamily: "cairo",
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                    color: ColorsManager.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Theme Selection
            Container(
              height: 55.h,
              padding: REdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTheme,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: isDark ? Colors.white : Colors.black54),
                  dropdownColor: Theme.of(context).cardColor,
                  items: [
                    DropdownMenuItem(
                      value: "light",
                      child: Row(
                        children: [
                          Icon(Icons.light_mode, size: 20.sp, color: Colors.amber),
                          SizedBox(width: 12.w),
                          Text(
                            StringsManager.light.tr(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "dark",
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode, size: 20.sp, color: Colors.indigo),
                          SizedBox(width: 12.w),
                          Text(
                            StringsManager.dark.tr(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                    setState(() {
                      selectedTheme = value;
                      if (selectedTheme == "light") {
                        themeProvider.changeTheme(ThemeMode.light);
                      } else {
                        themeProvider.changeTheme(ThemeMode.dark);
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Language Selection
            Container(
              height: 55.h,
              padding: REdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: isDark ? Colors.white : Colors.black54),
                  dropdownColor: Theme.of(context).cardColor,
                  items: [
                    DropdownMenuItem(
                      value: "en",
                      child: Row(
                        children: [
                          Text("🇺🇸", style: TextStyle(fontSize: 20.sp)),
                          SizedBox(width: 12.w),
                          Text(
                            StringsManager.english.tr(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "ar",
                      child: Row(
                        children: [
                          Text("🇸🇦", style: TextStyle(fontSize: 20.sp)),
                          SizedBox(width: 12.w),
                          Text(
                            StringsManager.arabic.tr(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) async {
                    await PrefsHelper.setLanguage(value!);
                    await context.setLocale(Locale(value));
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Page 1
      _buildOnboardingPage(
        context,
        image: AssetsManager.onboardingCard0,
        title: StringsManager.titleOnboarding0.tr(),
        subtitle: StringsManager.subtitleOnboarding0.tr(),
        showAppTitle: true,
      ),

      // Page 2
      _buildOnboardingPage(
        context,
        image: AssetsManager.onboardingCard1,
        title: StringsManager.titleOnboarding1.tr(),
        subtitle: StringsManager.subtitleOnboarding1.tr(),
      ),

      // Page 3
      _buildOnboardingPage(
        context,
        image: AssetsManager.onboardingCard3,
        title: StringsManager.titleOnboarding3.tr(),
        subtitle: StringsManager.subtitleOnboarding3.tr(),
      ),

      // Page 4
      _buildOnboardingPage(
        context,
        image: isDark ? AssetsManager.onboardingCard4dark : AssetsManager.onboardingCard4light,
        title: StringsManager.titleOnboarding4.tr(),
        subtitle: StringsManager.subtitleOnboarding4.tr(),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          StringsManager.raQib.tr(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              PrefsHelper.setScreen(true);
            },
            child: Padding(
              padding: REdgeInsets.only(right: 16),
              child: Text(
                StringsManager.skip.tr(),
                style: TextStyle(
                  color: ColorsManager.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "cairo",
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: pagesList,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 10.h),
            AnimatedSmoothIndicator(
              effect: WormEffect(
                dotHeight: 8.h,
                dotWidth: 8.w,
                activeDotColor: ColorsManager.primary,
                dotColor: Colors.grey.shade300,
              ),
              activeIndex: pageIndex,
              count: pagesList.length,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                if (pageIndex == pagesList.length - 1) {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  PrefsHelper.setScreen(true);
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
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
                pageIndex == pagesList.length - 1
                    ? StringsManager.getStarted.tr()
                    : StringsManager.next.tr(),
                style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
    bool showAppTitle = false,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Image.asset(
            image,
            height: 280.h,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              if (showAppTitle) ...[
                SizedBox(width: 8.w),
                Text(
                  StringsManager.raQib.tr(),
                  style: TextStyle(
                    fontFamily: "cairo",
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                    color: ColorsManager.primary,
                  ),
                ),
              ]
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}