part of 'balita_cubit.dart';

enum BalitaStatus { initial, loading, success, error }

class BalitaState extends Equatable {
  final BalitaStatus balitaStatus;
  final bool hasMoreBalita;
  final List<Balita> balitas;
  final dynamic balitaError;
  final String selectedFilter;

  const BalitaState({
    this.balitaStatus = BalitaStatus.initial,
    this.hasMoreBalita = true,
    this.balitas = const [],
    this.balitaError,
    this.selectedFilter = 'all',
  });

  BalitaState copyWith({
    BalitaStatus? balitaStatus,
    bool? hasMoreBalita,
    List<Balita>? balitas,
    dynamic balitaError,
    String? selectedFilter,
  }) {
    return BalitaState(
      balitaStatus: balitaStatus ?? this.balitaStatus,
      hasMoreBalita: hasMoreBalita ?? this.hasMoreBalita,
      balitas: balitas ?? this.balitas,
      balitaError: balitaError ?? this.balitaError,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [
    balitaStatus,
    hasMoreBalita,
    balitas,
    balitaError,
    selectedFilter,
  ];
}
