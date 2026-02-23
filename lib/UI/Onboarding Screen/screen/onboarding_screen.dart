import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Onboarding%20Screen/widgets/onboarding%20widget.dart';
import 'package:raqib/UI/login%20screen/screen/login_screen.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/prefs_helper.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/strings%20manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding" ;
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController() ;
  int pageIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    List<Widget> pagesList = [
      OnboardingWidget(
        title: StringsManager.titleOnboarding0.tr(),
        subtitle: StringsManager.subtitleOnboarding0.tr(),
        imageInPage: AssetsManager.onboardingCard0,
        is0page: true,
      ),
      OnboardingWidget(
        title: StringsManager.titleOnboarding1.tr(),
        subtitle: StringsManager.subtitleOnboarding1.tr(),
        imageInPage: AssetsManager.onboardingCard1,
      ),
      OnboardingWidget(
        title: StringsManager.titleOnboarding2.tr(),
        subtitle: StringsManager.subtitleOnboarding2.tr(),
        imageInPage: AssetsManager.onboardingCard2,
      ),
      OnboardingWidget(
        title: StringsManager.titleOnboarding3.tr(),
        subtitle: StringsManager.subtitleOnboarding3.tr(),
        imageInPage: AssetsManager.onboardingCard3,
      ),
      OnboardingWidget(
        title: StringsManager.titleOnboarding4.tr(),
        subtitle: StringsManager.subtitleOnboarding4.tr(),
        imageInPage: Theme.of(context).brightness == Brightness.light
            ?AssetsManager.onboardingCard4light
            :AssetsManager.onboardingCard4dark,
      ),
      OnboardingWidget(
        title: StringsManager.titleOnboarding5.tr(),
        subtitle: "",
        imageInPage: AssetsManager.onboardingCard5.tr(),
        is5page: true,
      ),
    ] ;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(StringsManager.raQib.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
       actions: [
         TextButton(
             onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              PrefsHelper.setScreen(true) ;
             },
             child: Padding(
               padding:  REdgeInsets.only(
                 right: 24
               ),
               child: Text(
                 StringsManager.skip.tr(),
                 style: TextStyle(

                     color: ColorsManager.primary,
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w500,
                     fontFamily: "cairo"
                 ),
               ),
             )
         ),
       ]
      ),

      body: Padding(
        padding:  REdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: pagesList,
                controller: pageController,
                onPageChanged: (index){
                  pageIndex = index ;
                  setState(() {

                  });
                },
              ),
            ),
            SizedBox(height: 8.h,),
            AnimatedSmoothIndicator(
                effect: WormEffect(
                  dotHeight: 10.h,
                  dotWidth: 10.w,
                  activeDotColor: ColorsManager.primary,
                ),
                activeIndex: pageIndex,
                count: pagesList.length,
              
            ),
            SizedBox(height: 72.h),
            pageIndex==pagesList.length-1
                ?CustomButton(
                text: StringsManager.getStarted.tr(),
                onPressed: (){
                  Navigator.pushReplacementNamed(context,LoginScreen.routeName);
                  PrefsHelper.setScreen(true) ;
                }
            )
                :CustomButton(
                text: StringsManager.next.tr(),
                onPressed: (){
                    if (pageIndex < pagesList.length - 1) {
                      pageIndex += 1;

                      pageController.animateToPage(
                        pageIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );

                      setState(() {});
                    }
                }
            ),
            SizedBox(
              height: 56.h,
            )
          ]
        ),
      ),
    );
  }
}
