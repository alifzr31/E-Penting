part of 'activation_cubit.dart';

enum Status { initial, loading, success, error }

class ActivationState extends Equatable {
  final Status checkStatus;
  final Map<String, dynamic>? checkResponseData;
  final String? checkErrorMessage;
  final Status activateStatus;
  final Map<String, dynamic>? activateResponseData;
  final String? activateErrorMessage;

  const new({
    this.checkStatus = .initial,
    this.checkResponseData,
    this.checkErrorMessage,
    this.activateStatus = .initial,
    this.activateResponseData,
    this.activateErrorMessage,
  });

  ActivationState copyWith({
    Status? checkStatus,
    Map<String, dynamic>? checkResponseData,
    String? checkErrorMessage,
    Status? activateStatus,
    Map<String, dynamic>? activateResponseData,
    String? activateErrorMessage,
  }) {
    return ActivationState(
      checkStatus: checkStatus ?? this.checkStatus,
      checkResponseData: checkResponseData,
      checkErrorMessage: checkErrorMessage,
      activateStatus: activateStatus ?? this.activateStatus,
      activateResponseData: activateResponseData,
      activateErrorMessage: activateErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    checkStatus,
    checkResponseData,
    checkErrorMessage,
    activateStatus,
    activateResponseData,
    activateErrorMessage,
  ];
}
