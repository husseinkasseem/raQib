import 'package:flutter/material.dart';
import 'package:raqib/core/prefs_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light ;
  initTheme(){
    bool isDark = PrefsHelper.getTheme();
      currentTheme = isDark ?
      ThemeMode.dark : ThemeMode.light;
      notifyListeners();
  }

  changeTheme(ThemeMode newThemeMode){
    currentTheme = newThemeMode ;
    currentTheme == ThemeMode.dark
        ?PrefsHelper.setTheme(true)
        :PrefsHelper.setTheme(false) ;
    notifyListeners() ;
  }
}