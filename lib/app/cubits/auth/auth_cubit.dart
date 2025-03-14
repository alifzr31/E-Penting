import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/configs/secure_storage/secure_storage.dart';
import 'package:epenting/app/models/profile.dart';
import 'package:epenting/app/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  void resetState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.initial,
          loginResponse: null,
          loginError: null,
          profileStatus: ProfileStatus.initial,
          profile: null,
          profileError: null,
          logoutStatus: LogoutStatus.initial,
          logoutResponse: null,
          logoutError: null,
        ),
      );
    });
  }

  void login({String? username, String? password}) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      final response = await _repository.login(
        username: username,
        password: password,
      );

      if (response.data['data']['level'] != 'kader_posyandu' &&
          response.data['data']['level'] != 'orangtua') {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.error,
            loginError:
                'Aplikasi E-Penting pada Android hanya dapat digunakan oleh Kader Posyandu ataupun Orang Tua Balita',
          ),
        );
      } else {
        await SecureStorage.writeStorage(
          key: 'token',
          value: response.data['token'],
        );

        await SecureStorage.writeStorage(
          key: 'profile',
          value: jsonEncode(response.data['data']),
        );

        emit(
          state.copyWith(
            loginStatus: LoginStatus.success,
            loginResponse: response,
          ),
        );
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          loginError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  Future<bool> hasToken() async {
    try {
      String? token = await SecureStorage.readStorage(key: 'token');

      if (token == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchProfile() async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    await Future.delayed(const Duration(milliseconds: 500), () async {
      final profileJson = await SecureStorage.readStorage(key: 'profile');
      final profile = await compute(
        (message) => profileFromStringJson(message),
        profileJson.toString(),
      );

      emit(
        state.copyWith(profileStatus: ProfileStatus.success, profile: profile),
      );
    });
  }

  void refetchProfile() async {
    emit(
      state.copyWith(
        profileStatus: ProfileStatus.initial,
        profile: null,
        profileError: null,
      ),
    );

    await fetchProfile();
  }

  void logout() async {
    emit(
      state.copyWith(
        profile: state.profile,
        logoutStatus: LogoutStatus.loading,
      ),
    );

    try {
      final response = await _repository.logout();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('fingerprint_enabled', false);
      await prefs.reload();
      await SecureStorage.deleteStorage(key: 'token');
      await SecureStorage.deleteStorage(key: 'profile');

      emit(
        state.copyWith(
          profile: state.profile,
          logoutStatus: LogoutStatus.success,
          logoutResponse: response,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          profile: state.profile,
          logoutStatus: LogoutStatus.error,
          logoutError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
