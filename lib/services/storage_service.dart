
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keys for storage
const USERNAMEKEY = "userName";
const MOBILEKEY = "mobileNumber";
const USERIDKEY = "userId";
const TOKENKEY = "token";
const ISLOGGEDIN = "isLoggedIn";
const GOLDRATEKEY = "goldRate";

class StorageService extends GetxService {
  final _box = GetStorage();

  /// ✅ Initialize GetStorage
  static Future<void> init() async {
    await GetStorage.init();
  }

  /// ✅ Save user data including userid
  Future<void> saveUser(String name, String token, String mobile, String userId) async {
    // Save in GetStorage
    await _box.write(USERNAMEKEY, name);
    await _box.write(USERIDKEY, userId);
    await _box.write(TOKENKEY, token);
    await _box.write(MOBILEKEY, mobile);
    await _box.write(USERIDKEY, userId);
    await _box.write(ISLOGGEDIN, true);

    // Save in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USERNAMEKEY, name);
    
    await prefs.setString(TOKENKEY, token);
    await prefs.setString(MOBILEKEY, mobile);
    await prefs.setString(USERIDKEY, userId);
    await prefs.setBool(ISLOGGEDIN, true);
  }

  /// ✅ Getters (synchronous)
  String? getName() => _box.read(USERNAMEKEY);
  String? getMobile() => _box.read(MOBILEKEY);
  String? getUserIdLocal() => _box.read(USERIDKEY);
  String? getToken() => _box.read(TOKENKEY);
  bool isLoggedIn() => _box.read(ISLOGGEDIN) ?? false;

  /// ✅ Getters (asynchronous)
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERNAMEKEY);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERIDKEY);
  }

  static Future<String?> getTokenAsync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKENKEY);
  }

  static Future<String?> getMobileAsync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(MOBILEKEY);
  }

  /// ✅ Save Gold Rate
  static Future<void> saveGoldRate(String rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(GOLDRATEKEY, rate);
  }

  /// ✅ Get Gold Rate
  static Future<String?> getGoldRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GOLDRATEKEY);
  }

  /// ✅ Update Name
  Future<void> saveUserName(String name) async {
    await _box.write(USERNAMEKEY, name);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USERNAMEKEY, name);
  }

  /// ✅ Clear all (logout)
  Future<void> erase() async {
    await _box.erase();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// ✅ Common headers for API requests
  Future<Map<String, String>> getAuthHeaders() async {
    final token = getToken() ?? await SharedPreferences.getInstance().then((p) => p.getString(TOKENKEY));
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future getTakenAmount() async {}

  static Future getTotalInvestment() async {}
}
