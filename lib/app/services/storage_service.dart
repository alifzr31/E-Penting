import 'package:biometric_storage/biometric_storage.dart';
import 'package:e_penting/app/configs/biom_storage/biom_storage.dart';
import 'package:e_penting/app/configs/secure_storage/secure_storage.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/helpers/crypto_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService(
    this._secureStorage,
    this._biomStorage,
    this._sharedPreferences,
  );

  final SecureStorage _secureStorage;
  final BiomStorage _biomStorage;
  final SharedPreferences _sharedPreferences;

  static String? _masterKey;

  String? get masterKey => _masterKey;

  void setMasterKey(String? key) {
    _masterKey = key;
  }

  void clearMasterKey() {
    _masterKey = null;
  }

  bool isBiometricEnabled() {
    return _sharedPreferences.getBool(AppStrings.biometricEnabled) ?? false;
  }

  Future<bool> hasUserData() async {
    final rawUserData = await _secureStorage.readStorage(
      key: AppStrings.userData,
    );
    return rawUserData != null && rawUserData.isNotEmpty;
  }

  Future<bool> checkBiometricHardware() async {
    return await _biomStorage.checkBiometricHardware();
  }

  Future<List<BiometricType>> checkAvailableBiometrics() async {
    return await _biomStorage.checkAvailableBiometrics();
  }

  Future<bool> setupBiometric(bool enable) async {
    try {
      if (enable) {
        final newMasterKey = CryptoHelper.generateMasterKey();
        final isSaved = await _biomStorage.write(value: newMasterKey);
        if (!isSaved) return false;

        final rawUserData = await _secureStorage.readStorage(
          key: AppStrings.userData,
        );

        if (rawUserData != null && rawUserData.isNotEmpty) {
          final encryptedUserData = CryptoHelper.encryptData(
            rawUserData,
            newMasterKey,
          );

          await _secureStorage.writeStorage(
            key: AppStrings.userData,
            value: encryptedUserData,
          );
        }

        _masterKey = newMasterKey;
        await _sharedPreferences.setBool(AppStrings.biometricEnabled, true);
        return true;
      } else {
        var keyToUse = _masterKey;
        if (keyToUse == null) {
          keyToUse = await _biomStorage.read();
          _masterKey = keyToUse;
        }

        if (keyToUse == null) return false;

        final encryptedUserData = await _secureStorage.readStorage(
          key: AppStrings.userData,
        );

        if (encryptedUserData != null && encryptedUserData.isNotEmpty) {
          try {
            final decryptedUserData = CryptoHelper.decryptData(
              encryptedUserData,
              keyToUse,
            );
            await _secureStorage.writeStorage(
              key: AppStrings.userData,
              value: decryptedUserData,
            );
          } catch (e) {
            if (kDebugMode) {
              print(
                'Gagal mendekripsi userData saat menonaktifkan biometrik: $e',
              );
            }
          }
        }

        await _biomStorage.delete();
        _masterKey = null;
        await _sharedPreferences.setBool(AppStrings.biometricEnabled, false);
        return true;
      }
    } on AuthException {
      rethrow;
    } catch (e) {
      if (kDebugMode) print('ERROR setupBiometric: $e');
      return false;
    }
  }

  Future<String?> readUserData({bool forceRefreshKey = false}) async {
    final isBiometric = isBiometricEnabled();

    try {
      if (isBiometric) {
        var keyToUse = forceRefreshKey ? null : _masterKey;
        if (keyToUse == null) {
          keyToUse = await _biomStorage.read();
          _masterKey = keyToUse;
        }

        if (keyToUse == null) return null;

        final encryptedUserData = await _secureStorage.readStorage(
          key: AppStrings.userData,
        );

        if (encryptedUserData == null || encryptedUserData.isEmpty) return null;

        return CryptoHelper.decryptData(encryptedUserData, keyToUse);
      } else {
        return await _secureStorage.readStorage(key: AppStrings.userData);
      }
    } on AuthException {
      rethrow;
    } catch (e) {
      if (kDebugMode) print('ERROR readUserData: $e');
      return null;
    }
  }

  Future<bool> writeUserData(String rawUserData) async {
    final isBiometric = isBiometricEnabled();

    try {
      if (isBiometric) {
        var keyToUse = _masterKey;
        if (keyToUse == null) {
          keyToUse = await _biomStorage.read();
          _masterKey = keyToUse;
        }

        if (keyToUse == null) {
          if (kDebugMode) {
            print('ERROR: Master Key tidak ditemukan saat writeUserData!');
          }
          return false;
        }

        final encryptedUserData = CryptoHelper.encryptData(
          rawUserData,
          keyToUse,
        );

        await _secureStorage.writeStorage(
          key: AppStrings.userData,
          value: encryptedUserData,
        );
        return true;
      } else {
        await _secureStorage.writeStorage(
          key: AppStrings.userData,
          value: rawUserData,
        );
        return true;
      }
    } catch (e) {
      if (kDebugMode) print('ERROR writeUserData: $e');
      return false;
    }
  }

  Future<void> clearAll() async {
    try {
      await _secureStorage.deleteStorage(key: AppStrings.userData);
      await _biomStorage.delete();
      _masterKey = null;
      await _sharedPreferences.setBool(AppStrings.biometricEnabled, false);
    } catch (e) {
      if (kDebugMode) print('ERROR clearAll: $e');
    }
  }
}
