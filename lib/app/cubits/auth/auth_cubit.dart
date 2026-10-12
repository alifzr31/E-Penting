import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/configs/secure_storage/secure_storage.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/repositories/auth_repository.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  new(this._repository, this._secureStorage) : super(const AuthState());

  final AuthRepository _repository;
  final SecureStorage _secureStorage;

  String? accessToken;

  void setToken(String? token) {
    accessToken = token;
  }

  void clearToken() {
    accessToken = null;
  }

  void resetState() {
    emit(
      state.copyWith(
        profileStatus: .initial,
        profile: null,
        children: const [],
        profileErrorMessage: null,
        logoutStatus: .initial,
        logoutResponseData: null,
        logoutErrorMessage: null,
      ),
    );
  }

  Future<void> fetchProfile() async {
    emit(state.copyWith(profileStatus: .loading));

    try {
      final profile = await _repository.fetchProfile();

      if (isClosed) return;

      emit(
        state.copyWith(
          profileStatus: .success,
          profile: profile,
          children: profile?.listAnak,
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          profileStatus: .error,
          profileErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchProfile() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        profileStatus: .initial,
        profile: null,
        children: const [],
        profileErrorMessage: null,
      ),
    );

    await fetchProfile();
  }

  void logout() async {
    emit(state.copyWith(profile: state.profile, logoutStatus: .loading));

    try {
      final responseData = await _repository.logout();

      if (isClosed || responseData == null) return;

      if (responseData['success']) {
        // await _secureStorage.deleteStorage(key: AppStrings.accessToken);
        // await _secureStorage.deleteStorage(key: AppStrings.profileData);
        await _secureStorage.deleteStorage(key: AppStrings.userData);
        clearToken();

        emit(
          state.copyWith(
            profile: state.profile,
            logoutStatus: .success,
            logoutResponseData: responseData,
          ),
        );
      } else {
        emit(
          state.copyWith(
            profile: state.profile,
            logoutStatus: .error,
            logoutErrorMessage: responseData['message'],
          ),
        );
      }
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          profile: state.profile,
          logoutStatus: .error,
          logoutErrorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _repository.cancelAllRequests();
    return super.close();
  }
}
