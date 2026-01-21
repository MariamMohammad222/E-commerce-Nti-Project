import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String tokenKey = 'token';
  static const String onboardingKey = 'onboarding';

  static Future <void> setData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, token);
  }
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  static Future<void> saveOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, value);
  }

  static Future<bool> getOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

}