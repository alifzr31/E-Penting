import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/firebase/firebase_remote.dart';
import 'package:e_penting/app/configs/secure_storage/secure_storage.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart' hide Status;
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart'
    hide Status;
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart'
    as package_info
    show Status;
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
    this._secureStorage,
  ) : super(const SplashState());

  final FirebaseRemote _firebaseRemote;
  final PackageInfoCubit _packageInfoCubit;
  final AuthCubit _authCubit;
  final SecureStorage _secureStorage;

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

      final accessToken = await _secureStorage.readStorage(
        key: AppStrings.accessToken,
      );

      final isLoggedIn = accessToken != null && accessToken.isNotEmpty;

      if (isLoggedIn) {
        _authCubit.setToken(accessToken);
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
}
