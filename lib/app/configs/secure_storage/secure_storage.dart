import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const new(this._flutterSecureStorage);

  final FlutterSecureStorage _flutterSecureStorage;

  Future<void> writeStorage({
    required String key,
    required String value,
  }) async {
    try {
      return await _flutterSecureStorage.write(key: key, value: value);
    } catch (e) {
      if (kDebugMode) print(e);
      return;
    }
  }

  Future<String?> readStorage({required String key}) async {
    try {
      return await _flutterSecureStorage.read(key: key);
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  Future<void> deleteStorage({required String key}) async {
    try {
      return await _flutterSecureStorage.delete(key: key);
    } catch (e) {
      if (kDebugMode) print(e);
      return;
    }
  }

  Future<void> deleteAllStorage() async {
    try {
      return await _flutterSecureStorage.deleteAll();
    } catch (e) {
      if (kDebugMode) print(e);
      return;
    }
  }
}
