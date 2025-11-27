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
  List<Widget> pagesList = [
    OnboardingWidget(
      title: StringsManager.titleOnboarding0,
      subtitle: StringsManager.subtitleOnboarding0,
      imageInPage: AssetsManager.onboardingCard0,
      is0page: true,
    ),
    OnboardingWidget(
      title: StringsManager.titleOnboarding1,
      subtitle: StringsManager.subtitleOnboarding1,
      imageInPage: AssetsManager.onboardingCard1,
    ),
    OnboardingWidget(
      title: StringsManager.titleOnboarding2,
      subtitle: StringsManager.subtitleOnboarding2,
      imageInPage: AssetsManager.onboardingCard2,
    ),
    OnboardingWidget(
      title: StringsManager.titleOnboarding3,
      subtitle: StringsManager.subtitleOnboarding3,
      imageInPage: AssetsManager.onboardingCard3,
    ),
    OnboardingWidget(
      title: StringsManager.titleOnboarding4,
      subtitle: StringsManager.subtitleOnboarding4,
      imageInPage: AssetsManager.onboardingCard4,
    ),

  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundApp,
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringsManager.raQib,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: ColorsManager.textPrimary
          ),
        ),
       actions: [
         TextButton(
             onPressed: (){

             },
             child: Padding(
               padding:  REdgeInsets.only(
                 right: 24
               ),
               child: Text(
                 StringsManager.skip,
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
        padding:  REdgeInsets.only(top: 24),
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
                text: StringsManager.getStarted,
                onPressed: (){
                  Navigator.pushReplacementNamed(context,LoginScreen.routeName);
                  PrefsHelper.setScreen(true) ;
                }
            )
                :CustomButton(
                text: StringsManager.next,
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
