import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuthentication;

  new(this._localAuthentication);

  Future<bool> checkBiometricHardware() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } on LocalAuthException catch (e) {
      throw AppException(e.description ?? AppStrings.unknownErrorApiMessage);
    } on PlatformException catch (e) {
      throw AppException(e.message ?? AppStrings.unknownErrorApiMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BiometricType>> checkAvailableBiometrics() async {
    try {
      return await _localAuthentication.getAvailableBiometrics();
    } on LocalAuthException catch (e) {
      throw AppException(e.description ?? AppStrings.unknownErrorApiMessage);
    } on PlatformException catch (e) {
      throw AppException(e.message ?? AppStrings.unknownErrorApiMessage);
    } catch (e) {
      rethrow;
    }
  }
}
