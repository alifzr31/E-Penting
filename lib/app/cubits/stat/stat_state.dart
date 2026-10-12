part of 'stat_cubit.dart';

enum Status { initial, loading, success, error }

class StatState extends Equatable {
  final Status percentageStatus;
  final List<Percentage> percentage;
  final String? percentageErrorMessage;

  const new({
    this.percentageStatus = .initial,
    this.percentage = const [],
    this.percentageErrorMessage,
  });

  StatState copyWith({
    Status? percentageStatus,
    List<Percentage>? percentage,
    String? percentageErrorMessage,
  }) {
    return StatState(
      percentageStatus: percentageStatus ?? this.percentageStatus,
      percentage: percentage ?? this.percentage,
      percentageErrorMessage: percentageErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    percentageStatus,
    percentage,
    percentageErrorMessage,
  ];
}
