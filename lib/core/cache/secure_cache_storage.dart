import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static const _storage = FlutterSecureStorage();

  Future<String?> getData({required String key}) => _storage.read(key: key);

  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> removeData({required String key}) async {
    await _storage.delete(key: key);
  }
}
