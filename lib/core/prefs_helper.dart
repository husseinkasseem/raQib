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
}
