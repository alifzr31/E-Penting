import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/repositories/storage_repository.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final DioClient _dioClient;
  final StorageRepository _storageRepository;

  new(this._dioClient, this._storageRepository);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<Profile?> fetchProfile() async {
    try {
      final userData = await _storageRepository.readUserData();

      if (userData == null || userData.isEmpty) return null;

      final userJson = jsonDecode(userData);

      final profileData = userJson[AppStrings.profileData];

      if (profileData == null || profileData.isEmpty) return null;

      return await compute((message) => profileFromJson(message), profileData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> logout() async {
    final key = 'logout';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/logout',
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  void cancelAllRequests() {
    DioHelper.removeAllCancelToken(_cancelTokens);
  }
}
