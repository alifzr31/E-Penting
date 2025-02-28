import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/repositories/statusgizi_repository.dart';
import 'package:equatable/equatable.dart';

part 'statusgizi_state.dart';

class StatusGiziCubit extends Cubit<StatusGiziState> {
  StatusGiziCubit(this._repository) : super(const StatusGiziState());

  final StatusGiziRepository _repository;

  // void fetchAllData(
  //   int? age,
  //   double? height,
  //   double? weight,
  //   String? gender,
  //   String? measure,
  // ) async {
  //   await fetchClassification(
  //     age: age,
  //     height: height,
  //     gender: gender,
  //     measure: measure,
  //   );
  //   await fetchWeight(age: age, gender: gender, weight: weight);
  //   await fetchNutrition(
  //     age: age,
  //     height: height,
  //     weight: weight,
  //     gender: gender,
  //     measure: measure,
  //   );
  // }

  Future<void> fetchData({
    int? age,
    double? height,
    double? weight,
    String? gender,
    String? measure,
  }) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));

    try {
      final classification = await _repository.fetchClassification(
        age: age,
        height: height,
        gender: gender,
        measure: measure,
      );

      final fetchedWeight = await _repository.fetchWeight(
        age: age,
        gender: gender,
        weight: weight,
      );

      final nutrition = await _repository.fetchNutrition(
        age: age,
        height: height,
        weight: weight,
        gender: gender,
        measure: measure,
      );

      emit(
        state.copyWith(
          dataStatus: DataStatus.success,
          classification: classification,
          weight: fetchedWeight,
          nutrition: nutrition,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          dataStatus: DataStatus.error,
          error:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  Future<void> fetchClassification({
    int? age,
    double? height,
    String? gender,
    String? measure,
  }) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));

    try {
      final classification = await _repository.fetchClassification(
        age: age,
        height: height,
        gender: gender,
        measure: measure,
      );

      emit(state.copyWith(classification: classification));
    } on DioException catch (e) {
      emit(
        state.copyWith(
          dataStatus: DataStatus.error,
          error:
              'Error Classification : ${e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan'}',
        ),
      );
    }
  }

  Future<void> fetchWeight({int? age, String? gender, double? weight}) async {
    try {
      final fetchedWeight = await _repository.fetchWeight(
        age: age,
        gender: gender,
        weight: weight,
      );

      emit(
        state.copyWith(
          classification: state.classification,
          weight: fetchedWeight,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          classification: state.classification,
          dataStatus: DataStatus.error,
          error:
              'Error Weight : ${e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan'}',
        ),
      );
    }
  }

  Future<void> fetchNutrition({
    int? age,
    double? height,
    double? weight,
    String? gender,
    String? measure,
  }) async {
    try {
      final nutrition = await _repository.fetchNutrition(
        age: age,
        height: height,
        weight: weight,
        gender: gender,
        measure: measure,
      );

      emit(
        state.copyWith(
          dataStatus: DataStatus.success,
          classification: state.classification,
          weight: state.weight,
          nutrition: nutrition,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          classification: state.classification,
          weight: state.weight,
          dataStatus: DataStatus.error,
          error:
              'Error Nutrition : ${e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan'}',
        ),
      );
    }
  }
}
