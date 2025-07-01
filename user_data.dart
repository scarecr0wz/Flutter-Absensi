import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String username = '';
  static String token = '';
  static bool isLoggedIn = false;

  static Future<void> setUserData(String name, String apiToken) async {
    username = name;
    token = apiToken;
    isLoggedIn = true;
    await _saveToPrefs(name, apiToken);
  }

  static Future<void> _saveToPrefs(String name, String apiToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('token', apiToken);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<bool> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? '';
    token = prefs.getString('token') ?? '';
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearUserData() async {
    username = '';
    token = '';
    isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('token');
    await prefs.setBool('isLoggedIn', false);
  }
}
