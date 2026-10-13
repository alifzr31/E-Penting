import 'dart:convert' show jsonEncode;

import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/repositories/login_repository.dart';
import 'package:e_penting/app/repositories/storage_repository.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  new(this._repository, this._storageRepository) : super(const LoginState());

  final LoginRepository _repository;
  final StorageRepository _storageRepository;

  void login({String? username, String? password}) async {
    emit(state.copyWith(status: .loading));

    try {
      final responseData = await _repository.login(
        username: username,
        password: password,
      );

      if (isClosed || responseData == null) return;

      if (responseData['success']) {
        final accessToken = responseData['token'];
        final profileData = responseData['data'];

        if (accessToken != null && profileData != null) {
          final userData = {
            AppStrings.accessToken: accessToken,
            AppStrings.profileData: profileData,
          };
          final userDataString = jsonEncode(userData);

          await _storageRepository.writeUserData(userDataString);
        }

        // if (profileData != null) {
        //   await _secureStorage.writeStorage(
        //     key: AppStrings.profileData,
        //     value: jsonEncode(profileData),
        //   );
        // }

        // if (accessToken != null) {
        //   await _secureStorage.writeStorage(
        //     key: AppStrings.accessToken,
        //     value: accessToken,
        //   );
        // }

        if (isClosed) return;

        emit(state.copyWith(status: .success, responseData: responseData));
      } else {
        emit(
          state.copyWith(status: .error, errorMessage: responseData['message']),
        );
      }
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(state.copyWith(status: .error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _repository.cancelAllRequests();
    return super.close();
  }
}
