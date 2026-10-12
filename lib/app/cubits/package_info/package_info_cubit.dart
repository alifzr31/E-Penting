import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'package_info_state.dart';

class PackageInfoCubit extends Cubit<PackageInfoState> {
  new() : super(const PackageInfoState());

  Future<void> fetchAppInfo() async {
    emit(state.copyWith(status: .loading));

    try {
      final packageInfo = await PackageInfo.fromPlatform();

      if (isClosed) return;

      emit(
        state.copyWith(
          status: .success,
          appName: packageInfo.appName,
          appVersion: packageInfo.version,
          appBuildNumber: int.tryParse(packageInfo.buildNumber),
        ),
      );
    } catch (e) {
      if (kDebugMode) print(e);

      if (isClosed) return;

      emit(state.copyWith(status: .error));
    }
  }
}
