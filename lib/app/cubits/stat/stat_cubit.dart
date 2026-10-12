import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/percentage.dart';
import 'package:e_penting/app/repositories/stat_repository.dart';
import 'package:equatable/equatable.dart';

part 'stat_state.dart';

class StatCubit extends Cubit<StatState> {
  StatCubit(this._repository) : super(const StatState());

  final StatRepository _repository;

  Future<void> fetchPercentage() async {
    emit(state.copyWith(percentageStatus: .loading));

    try {
      final percentage = await _repository.fetchPercentage();

      if (isClosed) return;

      emit(state.copyWith(percentageStatus: .success, percentage: percentage));
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          percentageStatus: .error,
          percentageErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchPercentage() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        percentageStatus: .initial,
        percentage: const [],
        percentageErrorMessage: null,
      ),
    );

    await fetchPercentage();
  }

  @override
  Future<void> close() {
    _repository.cancelAllRequests();
    return super.close();
  }
}
