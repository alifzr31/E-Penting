part of 'immunization_cubit.dart';

enum Status { initial, loading, success, error }

class ImmunizationState extends Equatable {
  final Status immunizationHistoryNikStatus;
  final List<ImmunizationHistoryNik> immunizationHistoriesNik;
  final String? immunizationHistoryNikErrorMessage;
  final Status latestImmunizationStatus;
  final List<Immunization> latestImmunizations;
  final String? latestImmunizationErrorMessage;
  final Status immunizationStatus;
  final List<Immunization> immunizations;
  final bool hasMoreImmunization;
  final String? immunizationErrorMessage;
  final Status immunizationDetailStatus;
  final ImmunizationDetail? immunizationDetail;
  final String? immunizationDetailErrorMessage;
  final Status formStatus;
  final Map<String, dynamic>? formResponseData;
  final String? formErrorMessage;

  const new({
    this.immunizationHistoryNikStatus = .initial,
    this.immunizationHistoriesNik = const [],
    this.immunizationHistoryNikErrorMessage,
    this.latestImmunizationStatus = .initial,
    this.latestImmunizations = const [],
    this.latestImmunizationErrorMessage,
    this.immunizationStatus = .initial,
    this.immunizations = const [],
    this.hasMoreImmunization = true,
    this.immunizationErrorMessage,
    this.immunizationDetailStatus = .initial,
    this.immunizationDetail,
    this.immunizationDetailErrorMessage,
    this.formStatus = .initial,
    this.formResponseData,
    this.formErrorMessage,
  });

  ImmunizationState copyWith({
    Status? immunizationHistoryNikStatus,
    List<ImmunizationHistoryNik>? immunizationHistoriesNik,
    String? immunizationHistoryNikErrorMessage,
    Status? latestImmunizationStatus,
    List<Immunization>? latestImmunizations,
    String? latestImmunizationErrorMessage,
    Status? immunizationStatus,
    List<Immunization>? immunizations,
    bool? hasMoreImmunization,
    String? immunizationErrorMessage,
    Status? immunizationDetailStatus,
    ImmunizationDetail? immunizationDetail,
    String? immunizationDetailErrorMessage,
    Status? formStatus,
    Map<String, dynamic>? formResponseData,
    String? formErrorMessage,
  }) {
    return ImmunizationState(
      immunizationHistoryNikStatus:
          immunizationHistoryNikStatus ?? this.immunizationHistoryNikStatus,
      immunizationHistoriesNik:
          immunizationHistoriesNik ?? this.immunizationHistoriesNik,
      immunizationHistoryNikErrorMessage: immunizationHistoryNikErrorMessage,
      latestImmunizationStatus:
          latestImmunizationStatus ?? this.latestImmunizationStatus,
      latestImmunizations: latestImmunizations ?? this.latestImmunizations,
      latestImmunizationErrorMessage: latestImmunizationErrorMessage,
      immunizationStatus: immunizationStatus ?? this.immunizationStatus,
      immunizations: immunizations ?? this.immunizations,
      hasMoreImmunization: hasMoreImmunization ?? this.hasMoreImmunization,
      immunizationErrorMessage: immunizationErrorMessage,
      immunizationDetailStatus:
          immunizationDetailStatus ?? this.immunizationDetailStatus,
      immunizationDetail: immunizationDetail,
      immunizationDetailErrorMessage: immunizationDetailErrorMessage,
      formStatus: formStatus ?? this.formStatus,
      formResponseData: formResponseData,
      formErrorMessage: formErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    immunizationHistoryNikStatus,
    immunizationHistoriesNik,
    immunizationHistoryNikErrorMessage,
    latestImmunizationStatus,
    latestImmunizations,
    latestImmunizationErrorMessage,
    immunizationStatus,
    immunizations,
    hasMoreImmunization,
    immunizationErrorMessage,
    immunizationDetailStatus,
    immunizationDetail,
    immunizationDetailErrorMessage,
    formStatus,
    formResponseData,
    formErrorMessage,
  ];
}
