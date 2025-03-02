part of 'dashboard_cubit.dart';

enum PercentageStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final PercentageStatus percentageStatus;
  final List<Percentage> percentages;
  final dynamic percentageError;

  const DashboardState({
    this.percentageStatus = PercentageStatus.initial,
    this.percentages = const [],
    this.percentageError,
  });

  DashboardState copyWith({
    PercentageStatus? percentageStatus,
    List<Percentage>? percentages,
    dynamic percentageError,
  }) {
    return DashboardState(
      percentageStatus: percentageStatus ?? this.percentageStatus,
      percentages: percentages ?? this.percentages,
      percentageError: percentageError ?? this.percentageError,
    );
  }

  @override
  List<Object?> get props => [percentageStatus, percentages, percentageError];
}
