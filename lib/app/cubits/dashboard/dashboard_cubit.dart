import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  Timer? _timer;

  void startTimer() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateGreetingMessage();
    });
  }

  void _updateGreetingMessage() {
    final hour = DateTime.now().hour;
    String newGreetingMessage = '';

    if (hour >= 5 && hour < 11) {
      newGreetingMessage = 'Wilujeng Enjing';
    } else if (hour >= 11 && hour < 15) {
      newGreetingMessage = 'Wilujeng Siang';
    } else if (hour >= 15 && hour < 18) {
      newGreetingMessage = 'Wilujeng Sonten';
    } else {
      newGreetingMessage = 'Wilujeng Wengi';
    }

    if (state.greetingMessage == newGreetingMessage) return;

    emit(state.copyWith(greetingMessage: newGreetingMessage));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
