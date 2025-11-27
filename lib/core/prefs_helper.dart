import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences prefs ;
  static init()async{
     prefs = await SharedPreferences.getInstance() ;

  }
  static setScreen(bool value){
    prefs.setBool("Onboarding", value) ;
  }
  static bool getScreen(){
    return  prefs.getBool("Onboarding")??false;
  }
}
