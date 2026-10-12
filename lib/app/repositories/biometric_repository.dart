import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/services/biometric_service.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:local_auth/local_auth.dart';

abstract class BiometricRepository {
  Future<bool> checkBiometricHardware();
  Future<List<BiometricType>> checkAvailableBiometrics();
}

class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricService _service;

  new(this._service);

  @override
  Future<bool> checkBiometricHardware() async {
    try {
      return await _service.checkBiometricHardware();
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
      return await _service.checkAvailableBiometrics();
    } on LocalAuthException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
