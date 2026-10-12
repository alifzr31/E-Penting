part of 'nutrition_cubit.dart';

enum Status { initial, loading, success, error }

class NutritionState extends Equatable {
  final Status status;
  final String? classification;
  final String? weight;
  final String? nutrition;
  final String? errorMessage;

  const new({
    this.status = .initial,
    this.classification,
    this.weight,
    this.nutrition,
    this.errorMessage,
  });

  NutritionState copyWith({
    Status? status,
    String? classification,
    String? weight,
    String? nutrition,
    String? errorMessage,
  }) {
    return NutritionState(
      status: status ?? this.status,
      classification: classification,
      weight: weight,
      nutrition: nutrition,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    classification,
    weight,
    nutrition,
    errorMessage,
  ];
}
