import 'package:biometric_storage/biometric_storage.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/services/storage_service.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:local_auth/local_auth.dart';

abstract class StorageRepository {
  bool isBiometricEnabled();
  Future<bool> hasUserData();
  Future<bool> checkBiometricHardware();
  Future<List<BiometricType>> checkAvailableBiometrics();
  Future<bool> setupBiometric({required bool enable});
  Future<String?> readUserData({bool forceRefreshKey = false});
  Future<bool> writeUserData(String rawUserData);
  Future<void> clearAll();
}

class StorageRepositoryImpl implements StorageRepository {
  final StorageService _storageService;

  StorageRepositoryImpl(this._storageService);

  @override
  bool isBiometricEnabled() {
    return _storageService.isBiometricEnabled();
  }

  @override
  Future<bool> hasUserData() async {
    try {
      return await _storageService.hasUserData();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> checkBiometricHardware() async {
    try {
      return await _storageService.checkBiometricHardware();
    } on LocalAuthException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<BiometricType>> checkAvailableBiometrics() async {
    try {
      return await _storageService.checkAvailableBiometrics();
    } on LocalAuthException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<bool> setupBiometric({required bool enable}) async {
    try {
      return await _storageService.setupBiometric(enable);
    } on AuthException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<String?> readUserData({bool forceRefreshKey = false}) async {
    try {
      return await _storageService.readUserData(
        forceRefreshKey: forceRefreshKey,
      );
    } on AuthException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<bool> writeUserData(String rawUserData) async {
    try {
      return await _storageService.writeUserData(rawUserData);
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _storageService.clearAll();
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
