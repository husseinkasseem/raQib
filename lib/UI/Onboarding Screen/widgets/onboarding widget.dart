import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';
import 'package:raqib/core/prefs_helper.dart';
import 'package:raqib/core/strings%20manager.dart';
import 'package:raqib/core/themeProvider.dart';

class OnboardingWidget extends StatefulWidget {
   String imageInPage ;
   String title ;
   String subtitle ;
   bool is0page ;
   bool is5page ;


  OnboardingWidget({
     required this.imageInPage,
     required this.title,
     required this.subtitle,
    this.is0page=false,
    this.is5page = false,
});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  String? selectedTheme = "light";
  String? selectedLanguage = "en";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              height: 340.h,
              width: 360.w,
              widget.imageInPage
            ),
            SizedBox(height: 24.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                      widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(width:  8.w,),
                Text(
                  widget.is0page==false?"":StringsManager.raQib.tr(),
                  style: TextStyle(
                      fontFamily: "cairo",
                      fontWeight: FontWeight.w700,
                      fontSize: 34.sp,
                      color: ColorsManager.primary,
                    decoration:  TextDecoration.none
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            SizedBox(height: 24.h,),
            widget.is5page==true
            ?Column(
              children: [
                InputDecorator(

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: ColorsManager.textSecondaryDark
                        )
                      ),
                    ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isDense: true,
                          value: null,
                          isExpanded: true,
                          iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
                          iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
                          dropdownColor: Theme.of(context).colorScheme.tertiary,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          hint: Text(
                           StringsManager.chooseTheme.tr()
                          ),
                          items:  [
                             DropdownMenuItem(
                             value: "light",
                             child: Text(StringsManager.light.tr())
                             ),
                             DropdownMenuItem(
                             value: "dark",
                             child: Text(StringsManager.dark.tr())
                         ),
                      ],
                          onChanged: (value){
                            ThemeProvider themeProvider =
                            Provider.of<ThemeProvider>(context,listen: false);
                            setState(() {
                              selectedTheme = value ;
                              if(selectedTheme == "light"){
                                themeProvider.changeTheme(ThemeMode.light);
                              }else{
                                themeProvider.changeTheme(ThemeMode.dark);
                                PrefsHelper.getTheme() ;
                              }
                            });
                          }
                      )
                  ),
                ),
                SizedBox(height: 24.h,),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            color: ColorsManager.textSecondaryDark
                        )
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isDense: true,
                          value: null,
                          hint: Text(
                            StringsManager.chooseLanguage.tr()
                          ),
                          isExpanded: true,
                          iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
                          iconDisabledColor: Theme.of(context).colorScheme.onSecondary,
                          dropdownColor: Theme.of(context).colorScheme.tertiary,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          items:  [
                            DropdownMenuItem(
                                value: "en",
                                child: Text(StringsManager.english.tr())
                            ),
                            DropdownMenuItem(
                                value: "ar",
                                child: Text(StringsManager.arabic.tr()),

                            ),
                          ],
                          onChanged: (value)async{
                            await PrefsHelper.setLanguage(value!);
                            await context.setLocale(Locale(value));
                            selectedLanguage = value ;
                            setState(() {

                            });
                          }
                      )
                  ),
                ),
              ],
            )
            :SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
