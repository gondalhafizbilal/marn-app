import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) => _prefs?.getString(key);

  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await _prefs?.setString(key, value);
  }

  Future<void> removeData({required String key}) async {
    await _prefs?.remove(key);
  }
}
