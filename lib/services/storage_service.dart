import 'package:shared_preferences/shared_preferences.dart';

const USERNAMEKEY = "userName";
const MOBILEKEY = "mobileNumber";
const USERIDKEY = "userId";  // ✅ added for userId

class StorageService {
  static Future<void> saveLogin(
      String token, String mobile, String name, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("token", token);
    await prefs.setString(USERNAMEKEY, name);
    await prefs.setString(MOBILEKEY, mobile);
    await prefs.setString(USERIDKEY, userId);   // ✅ save userId
  }

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USERNAMEKEY, name);
  }
  static Future<void> userId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USERIDKEY, userId);   // ✅ save userId
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERNAMEKEY);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERIDKEY);  // ✅ retrieve userId
  }

  static Future<void> erase() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
