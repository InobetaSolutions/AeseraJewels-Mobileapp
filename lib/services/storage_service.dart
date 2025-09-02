import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
const USERNAMEKEY = "userName";
const MOBILEKEY = "mobileNumber";
const USERIDKEY = "userId";
const TOKENKEY = "token";
const ISLOGGEDIN = "isLoggedIn";
const GOLDRATEKEY = "goldRate"; // ✅ New key
 
class StorageService extends GetxService {
  final _box = GetStorage();
 
  /// ✅ Initialize GetStorage
  static Future<void> init() async {
    await GetStorage.init();
  }
 
  /// ✅ Save user data (works for both GetStorage + SharedPreferences)
  Future<void> saveUser(String name, String token, String mobile, String userId) async {
    // Save in GetStorage
    await _box.write(USERNAMEKEY, name);
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
 
  /// ✅ Getters
  String? getName() => _box.read(USERNAMEKEY);
  String? getMobile() => _box.read(MOBILEKEY);
  String? getUserIdLocal() => _box.read(USERIDKEY);
  String? getToken() => _box.read(TOKENKEY);
  bool isLoggedIn() => _box.read(ISLOGGEDIN) ?? false;
 
  /// ✅ Async Getters (from SharedPreferences if needed)
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
 
  /// ✅ Save Gold Rate (new method)
  static Future<void> saveGoldRate(String rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(GOLDRATEKEY, rate);
    print("✅ Gold Rate saved locally: $rate");
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
}
 
 