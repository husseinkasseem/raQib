import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setScreen(bool value) async {
    await prefs?.setBool("Onboarding", value);
  }

  static bool getScreen() {
    return prefs?.getBool("Onboarding") ?? false;
  }
  static Future<void> setTheme(bool value) async {
    await prefs?.setBool("Theme", value);
  }

  static bool getTheme() {
    return prefs?.getBool("Theme") ?? false;
  }
  static Future<void> setLanguage(String value) async {
    await prefs?.setString("Language", value);
  }

  static String getLanguage() {
    return prefs?.getString("Language")?? "en";
  }
}
