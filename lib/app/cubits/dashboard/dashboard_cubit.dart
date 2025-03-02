import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/percentage.dart';
import 'package:epenting/app/repositories/dashboard_repository.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._repository) : super(const DashboardState());

  final DashboardRepository _repository;

  Future<void> fetchPercentage() async {
    emit(state.copyWith(percentageStatus: PercentageStatus.loading));

    try {
      final percentages = await _repository.fetchPercentage();

      emit(
        state.copyWith(
          percentageStatus: PercentageStatus.success,
          percentages: percentages,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          percentageStatus: PercentageStatus.error,
          percentageError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchPercentage() async {
    emit(
      state.copyWith(
        percentageStatus: PercentageStatus.initial,
        percentages: const [],
        percentageError: null,
      ),
    );

    await fetchPercentage();
  }
}
