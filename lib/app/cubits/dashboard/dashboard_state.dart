part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final String? greetingMessage;

  const new({this.greetingMessage});

  DashboardState copyWith({String? greetingMessage}) {
    return DashboardState(greetingMessage: greetingMessage);
  }

  @override
  List<Object?> get props => [greetingMessage];
}
