import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/repositories/activation_repository.dart';
import 'package:equatable/equatable.dart';

part 'activation_state.dart';

class ActivationCubit extends Cubit<ActivationState> {
  new(this._repository) : super(const ActivationState());

  final ActivationRepository _repository;

  void checkParentNik({String? parentNik}) async {
    emit(state.copyWith(checkStatus: .loading));

    try {
      final checkResponseData = await _repository.checkParentNik(
        parentNik: parentNik,
      );

      if (isClosed || checkResponseData == null) return;

      if (checkResponseData['success']) {
        emit(
          state.copyWith(
            checkStatus: .success,
            checkResponseData: checkResponseData,
          ),
        );
      } else {
        emit(
          state.copyWith(
            checkStatus: .error,
            checkErrorMessage: checkResponseData['message'],
          ),
        );
      }
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(checkStatus: .error, checkErrorMessage: e.toString()),
      );
    }
  }

  void resetCheckState() {
    emit(
      state.copyWith(
        checkStatus: .initial,
        checkResponseData: null,
        checkErrorMessage: null,
      ),
    );
  }

  void activateParentAccount({String? parentNik}) async {
    emit(
      state.copyWith(
        checkResponseData: state.checkResponseData,
        activateStatus: .loading,
      ),
    );

    try {
      final activateResponseData = await _repository.activateParentAccount(
        parentNik: parentNik,
      );

      if (isClosed || activateResponseData == null) return;

      if (activateResponseData['success']) {
        emit(
          state.copyWith(
            checkResponseData: state.checkResponseData,
            activateStatus: .success,
            activateResponseData: activateResponseData,
          ),
        );
      } else {
        emit(
          state.copyWith(
            checkResponseData: state.checkResponseData,
            activateStatus: .error,
            activateErrorMessage: activateResponseData['message'],
          ),
        );
      }
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkResponseData: state.checkResponseData,
          activateStatus: .error,
          activateErrorMessage: e.toString(),
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
