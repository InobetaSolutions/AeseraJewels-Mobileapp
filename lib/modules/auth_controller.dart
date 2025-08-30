import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var userName = "".obs;

  /// Save user data
  Future<void> registerUser(String name) async {
    userName.value = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("userName", name);
  }

  /// Load saved user data
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("userName") ?? "";
  }

  /// Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userName.value = "";
  }
}
