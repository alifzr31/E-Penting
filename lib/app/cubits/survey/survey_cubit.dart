import 'package:bloc/bloc.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyCubit extends Cubit<bool> {
  new(this._sharedPreferences) : super(false);

  final SharedPreferences _sharedPreferences;

  void checkHasRating() {
    final lastSurveyDateStr = _sharedPreferences.getString(
      AppStrings.lastSurveyDate,
    );

    if (lastSurveyDateStr == null) return;

    final lastSurveyDate = DateTime.tryParse(lastSurveyDateStr);
    final now = DateTime.now();

    if (lastSurveyDate == null) return;

    final difference = now.difference(lastSurveyDate).inDays;

    if (isClosed) return;

    emit(difference < 7);
  }

  void markHasRating() async {
    await _sharedPreferences.setString(
      AppStrings.lastSurveyDate,
      DateTime.now().toIso8601String(),
    );
    await _sharedPreferences.reload();
  }
}
