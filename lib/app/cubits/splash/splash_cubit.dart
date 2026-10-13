import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/firebase/firebase_remote.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart' hide Status;
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart'
    hide Status;
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart'
    as package_info
    show Status;
import 'package:e_penting/app/repositories/storage_repository.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  new(
    this._firebaseRemote,
    this._packageInfoCubit,
    this._authCubit,
    this._storageRepository,
  ) : super(const SplashState());

  final FirebaseRemote _firebaseRemote;
  final PackageInfoCubit _packageInfoCubit;
  final AuthCubit _authCubit;
  final StorageRepository _storageRepository;

  Future<void> initApp() async {
    emit(state.copyWith(status: .loading));

    try {
      if (_packageInfoCubit.state.status != package_info.Status.success) {
        try {
          await _packageInfoCubit.stream
              .firstWhere(
                (state) =>
                    state.status == package_info.Status.success ||
                    state.status == package_info.Status.error,
              )
              .timeout(const Duration(seconds: 3));
        } catch (_) {}
      }

      // BASE API URL ENV
      await _firebaseRemote.init();

      await Future.delayed(const Duration(seconds: 2));

      final latestBuildNumber = _firebaseRemote.latestBuildNumber;
      final currentBuildNumber = _packageInfoCubit.state.appBuildNumber ?? 0;

      final isNeedUpdate = latestBuildNumber > currentBuildNumber;

      if (isNeedUpdate) {
        if (isClosed) return;

        emit(
          state.copyWith(status: .success, isNeedUpdate: true, target: .update),
        );
        return;
      }

      if (isClosed) return;

      final prefs = await SharedPreferences.getInstance();
      final isOpenedOnboard = prefs.getBool('opened_onboard') ?? false;

      if (!isOpenedOnboard) {
        emit(
          state.copyWith(
            status: .success,
            isNeedUpdate: false,
            isOpenedOnboard: false,
            target: .onboard,
          ),
        );
        return;
      }

      final hasSession = await _storageRepository.hasUserData();

      if (!hasSession) {
        emit(
          state.copyWith(
            status: .success,
            isNeedUpdate: false,
            isOpenedOnboard: true,
            isLoggedIn: false,
            target: .login,
          ),
        );
        return;
      }

      final isBiometric = _storageRepository.isBiometricEnabled();

      if (isBiometric) {
        await authenticateBiometric();
      } else {
        final userData = await _storageRepository.readUserData();
        if (userData != null && userData.isNotEmpty) {
          final userJson = jsonDecode(userData);
          _authCubit.setToken(userJson[AppStrings.accessToken]);

          emit(
            state.copyWith(
              status: .success,
              isNeedUpdate: false,
              isOpenedOnboard: true,
              isLoggedIn: true,
              target: .dashboard,
            ),
          );
        } else {
          await _authCubit.forceLogout();

          if (isClosed) return;

          emit(
            state.copyWith(
              status: .success,
              isNeedUpdate: false,
              isOpenedOnboard: true,
              isLoggedIn: false,
              target: .login,
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in SplashCubit initApp: $e');
      }

      if (isClosed) return;

      emit(
        state.copyWith(
          status: .error,
          errorMessage: e.toString(),
          target: .login,
        ),
      );
    }
  }

  Future<void> authenticateBiometric() async {
    if (state.isBiometricPromptActive) return;

    emit(
      state.copyWith(
        status: .loading,
        isBiometricCancelled: false,
        isBiometricPromptActive: true,
      ),
    );

    try {
      final userData = await _storageRepository.readUserData(
        forceRefreshKey: true,
      );

      if (isClosed) return;

      if (userData != null && userData.isNotEmpty) {
        final userJson = jsonDecode(userData);
        _authCubit.setToken(userJson[AppStrings.accessToken]);

        emit(
          state.copyWith(
            status: .success,
            isNeedUpdate: false,
            isOpenedOnboard: true,
            isLoggedIn: true,
            isBiometricCancelled: false,
            isBiometricPromptActive: false,
            target: .dashboard,
          ),
        );
      } else {
        final errorMessage =
            'Sesi tidak ditemukan/habis, silahkan masuk kembali.';
        await _authCubit.forceLogout(errorMessage: errorMessage);

        if (isClosed) return;

        emit(
          state.copyWith(
            status: .error,
            isLoggedIn: false,
            isBiometricCancelled: false,
            isBiometricPromptActive: false,
            errorMessage: errorMessage,
            target: .login,
          ),
        );
      }
    } on AuthException catch (e) {
      if (isClosed) return;

      if (e.code == .canceled ||
          e.code == .userCanceled ||
          e.code == .timeout) {
        emit(
          state.copyWith(
            status: .success,
            isBiometricCancelled: true,
            isBiometricPromptActive: false,
          ),
        );
        return;
      }

      final errorMessage = e.message.toLowerCase();
      final isTemporaryLockout =
          errorMessage.contains('too many attempts') ||
          errorMessage.contains('locked out') ||
          errorMessage.contains('coba lagi') ||
          errorMessage.contains('try again');

      if (isTemporaryLockout) {
        emit(
          state.copyWith(
            status: .success,
            isBiometricCancelled: true,
            isBiometricPromptActive: false,
            errorMessage: 'Sensor sidik jari terkunci sementara, silahkan coba beberapa saat lagi.',
          ),
        );
        return;
      }

      final isRetryableSensorError =
          errorMessage.contains('key user not authenticated') ||
          errorMessage.contains('unexpected authentication error') ||
          errorMessage.contains('illegalblocksizeexception') ||
          errorMessage.contains('keystore code: -26') ||
          e.code == .unknown;

      final isPermanentlyInvalidated =
          errorMessage.contains('keypermanentlyinvalidated') ||
          errorMessage.contains('permanently locked out');

      if (isRetryableSensorError && !isPermanentlyInvalidated) {
        emit(
          state.copyWith(
            status: .success,
            isBiometricCancelled: true,
            isBiometricPromptActive: false,
            errorMessage: 'Gagal memindai sidik jari, silahkan coba ketuk tombol Masuk kembali.',
          ),
        );
        return;
      }

      final fatalMsg =
          'Keamanan biometrik perangkat telah diubah atau tidak valid, silahkan masuk kembali dengan akun Anda.';
      await _authCubit.forceLogout(errorMessage: fatalMsg);

      if (isClosed) return;

      emit(
        state.copyWith(
          status: .error,
          isLoggedIn: false,
          isBiometricCancelled: false,
          isBiometricPromptActive: false,
          errorMessage: fatalMsg,
          target: .login,
        ),
      );
    } catch (_) {
      if (isClosed) return;

      const genericMsg =
          'Terjadi kesalahan pada sesi Anda, silahkan masuk kembali.';
      await _authCubit.forceLogout(errorMessage: genericMsg);

      if (isClosed) return;

      emit(
        state.copyWith(
          status: .error,
          isLoggedIn: false,
          isBiometricCancelled: false,
          isBiometricPromptActive: false,
          errorMessage: genericMsg,
          target: .login,
        ),
      );
    }
  }
}
