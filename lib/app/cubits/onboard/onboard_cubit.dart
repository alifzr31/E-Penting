import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  new() : super(const OnboardState());

  void onNextFinishPage(int currentPage) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (isClosed) return;

    if (currentPage == 0) {
      emit(state.copyWith(pageStatus: PageStatus.first));
    } else {
      await sharedPreferences.setBool('opened_onboard', true);
      await sharedPreferences.reload();

      emit(state.copyWith(pageStatus: PageStatus.last));
    }
  }
}
