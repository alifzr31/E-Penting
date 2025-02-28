part of 'statusgizi_cubit.dart';

enum DataStatus { initial, loading, success, error }

class StatusGiziState extends Equatable {
  final DataStatus dataStatus;
  final String? classification;
  final String? weight;
  final String? nutrition;
  final dynamic error;

  const StatusGiziState({
    this.dataStatus = DataStatus.initial,
    this.classification,
    this.weight,
    this.nutrition,
    this.error,
  });

  StatusGiziState copyWith({
    DataStatus? dataStatus,
    String? classification,
    String? weight,
    String? nutrition,
    dynamic error,
  }) {
    return StatusGiziState(
      dataStatus: dataStatus ?? this.dataStatus,
      classification: classification,
      weight: weight,
      nutrition: nutrition,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    dataStatus,
    classification,
    weight,
    nutrition,
    error,
  ];
}
