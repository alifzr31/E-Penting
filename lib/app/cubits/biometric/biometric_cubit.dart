import 'package:bloc/bloc.dart';
import 'package:e_penting/app/repositories/biometric_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:local_auth/local_auth.dart'
    show BiometricType, LocalAuthException;

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit(this._repository) : super(const BiometricState());

  final BiometricRepository _repository;

  Future<void> checkBiometric() async {
    await checkBiometricHardware();
    await checkAvailableBiometrics();
  }

  Future<void> checkBiometricHardware() async {
    emit(state.copyWith(checkBiometricHardwareStatus: .loading));

    try {
      final hasBiometricHardware = await _repository.checkBiometricHardware();

      if (isClosed) return;

      emit(
        state.copyWith(
          checkBiometricHardwareStatus: .success,
          hasBiometricHardware: hasBiometricHardware,
        ),
      );
    } on LocalAuthException catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkBiometricHardwareStatus: .error,
          checkBiometricHardwareErrorMessage: e.toString(),
        ),
      );
    } on PlatformException catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkBiometricHardwareStatus: .error,
          checkBiometricHardwareErrorMessage: e.toString(),
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkBiometricHardwareStatus: .error,
          checkBiometricHardwareErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> checkAvailableBiometrics() async {
    emit(state.copyWith(checkAvailableBiometricsStatus: .loading));

    try {
      final availableBiometrics = await _repository.checkAvailableBiometrics();

      if (isClosed) return;

      emit(
        state.copyWith(
          checkAvailableBiometricsStatus: .success,
          availableBiometrics: availableBiometrics,
        ),
      );
    } on LocalAuthException catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkAvailableBiometricsStatus: .error,
          checkAvailableBiometricsErrorMessage: e.toString(),
        ),
      );
    } on PlatformException catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkAvailableBiometricsStatus: .error,
          checkAvailableBiometricsErrorMessage: e.toString(),
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkAvailableBiometricsStatus: .error,
          checkAvailableBiometricsErrorMessage: e.toString(),
        ),
      );
    }
  }
}
