import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/repositories/nutrition_repository.dart';
import 'package:equatable/equatable.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  new(this._repository) : super(const NutritionState());

  final NutritionRepository _repository;

  Future<void> fetchNutritionCheck({
    String? monthAge,
    String? tall,
    String? weight,
    String? measureType,
    String? gender,
  }) async {
    emit(state.copyWith(status: .loading));

    try {
      final classification = await _repository.fetchClassification(
        monthAge: monthAge,
        tall: tall,
        measureType: measureType,
        gender: gender,
      );

      final weightResult = await _repository.fetchWeight(
        monthAge: monthAge,
        gender: gender,
        weight: weight,
      );

      final nutrition = await _repository.fetchNutrition(
        monthAge: monthAge,
        tall: tall,
        weight: weight,
        gender: gender,
        measureType: measureType,
      );

      if (isClosed) return;

      emit(
        state.copyWith(
          status: .success,
          classification: classification,
          weight: weightResult,
          nutrition: nutrition,
        ),
      );
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
