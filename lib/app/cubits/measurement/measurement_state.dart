part of 'measurement_cubit.dart';

enum Status { initial, loading, success, error }

class MeasurementState extends Equatable {
  final Status measurementHistoryNikStatus;
  final List<MeasurementHistoryNik> measurementHistoryNik;
  final String? measurementHistoryNikErrorMessage;
  final Status heightMeasurementGraphNikStatus;
  final MeasurementGraphNik? heightMeasurementGraphNik;
  final String? heightMeasurementGraphNikErrorMessage;
  final Status weightMeasurementGraphNikStatus;
  final MeasurementGraphNik? weightMeasurementGraphNik;
  final String? weightMeasurementGraphNikErrorMessage;
  final Status latestMeasurementsStatus;
  final List<Measurement> latestMeasurements;
  final String? latestMeasurementsError;
  final Status measurementStatus;
  final List<Measurement> measurements;
  final bool hasMoreMeasurement;
  final String? measurementErrorMessage;
  final Status measurementDetailStatus;
  final MeasurementDetail? measurementDetail;
  final String? measurementDetailErrorMessage;
  final Status formStatus;
  final Map<String, dynamic>? formResponseData;
  final String? formErrorMessage;

  const new({
    this.measurementHistoryNikStatus = .initial,
    this.measurementHistoryNik = const [],
    this.measurementHistoryNikErrorMessage,
    this.heightMeasurementGraphNikStatus = .initial,
    this.heightMeasurementGraphNik,
    this.heightMeasurementGraphNikErrorMessage,
    this.weightMeasurementGraphNikStatus = .initial,
    this.weightMeasurementGraphNik,
    this.weightMeasurementGraphNikErrorMessage,
    this.latestMeasurementsStatus = .initial,
    this.latestMeasurements = const [],
    this.latestMeasurementsError,
    this.measurementStatus = .initial,
    this.measurements = const [],
    this.hasMoreMeasurement = true,
    this.measurementErrorMessage,
    this.measurementDetailStatus = .initial,
    this.measurementDetail,
    this.measurementDetailErrorMessage,
    this.formStatus = .initial,
    this.formResponseData,
    this.formErrorMessage,
  });

  MeasurementState copyWith({
    Status? measurementHistoryNikStatus,
    List<MeasurementHistoryNik>? measurementHistoryNik,
    String? measurementHistoryNikErrorMessage,
    Status? heightMeasurementGraphNikStatus,
    MeasurementGraphNik? heightMeasurementGraphNik,
    String? heightMeasurementGraphNikErrorMessage,
    Status? weightMeasurementGraphNikStatus,
    MeasurementGraphNik? weightMeasurementGraphNik,
    String? weightMeasurementGraphNikErrorMessage,
    Status? latestMeasurementsStatus,
    List<Measurement>? latestMeasurements,
    String? latestMeasurementsError,
    Status? measurementStatus,
    List<Measurement>? measurements,
    bool? hasMoreMeasurement,
    String? measurementErrorMessage,
    Status? measurementDetailStatus,
    MeasurementDetail? measurementDetail,
    String? measurementDetailErrorMessage,
    Status? formStatus,
    Map<String, dynamic>? formResponseData,
    String? formErrorMessage,
  }) {
    return MeasurementState(
      measurementHistoryNikStatus:
          measurementHistoryNikStatus ?? this.measurementHistoryNikStatus,
      measurementHistoryNik:
          measurementHistoryNik ?? this.measurementHistoryNik,
      measurementHistoryNikErrorMessage: measurementHistoryNikErrorMessage,
      heightMeasurementGraphNikStatus:
          heightMeasurementGraphNikStatus ??
          this.heightMeasurementGraphNikStatus,
      heightMeasurementGraphNik:
          heightMeasurementGraphNik ?? this.heightMeasurementGraphNik,
      heightMeasurementGraphNikErrorMessage:
          heightMeasurementGraphNikErrorMessage,
      weightMeasurementGraphNikStatus:
          weightMeasurementGraphNikStatus ??
          this.weightMeasurementGraphNikStatus,
      weightMeasurementGraphNik:
          weightMeasurementGraphNik ?? this.weightMeasurementGraphNik,
      weightMeasurementGraphNikErrorMessage:
          weightMeasurementGraphNikErrorMessage,
      latestMeasurementsStatus:
          latestMeasurementsStatus ?? this.latestMeasurementsStatus,
      latestMeasurements: latestMeasurements ?? this.latestMeasurements,
      latestMeasurementsError: latestMeasurementsError,
      measurementStatus: measurementStatus ?? this.measurementStatus,
      measurements: measurements ?? this.measurements,
      hasMoreMeasurement: hasMoreMeasurement ?? this.hasMoreMeasurement,
      measurementErrorMessage: measurementErrorMessage,
      measurementDetailStatus:
          measurementDetailStatus ?? this.measurementDetailStatus,
      measurementDetail: measurementDetail,
      measurementDetailErrorMessage: measurementDetailErrorMessage,
      formStatus: formStatus ?? this.formStatus,
      formResponseData: formResponseData,
      formErrorMessage: formErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    measurementHistoryNikStatus,
    measurementHistoryNik,
    measurementHistoryNikErrorMessage,
    heightMeasurementGraphNikStatus,
    heightMeasurementGraphNik,
    heightMeasurementGraphNikErrorMessage,
    weightMeasurementGraphNikStatus,
    weightMeasurementGraphNik,
    weightMeasurementGraphNikErrorMessage,
    latestMeasurementsStatus,
    latestMeasurements,
    latestMeasurementsError,
    measurementStatus,
    measurements,
    hasMoreMeasurement,
    measurementErrorMessage,
    measurementDetailStatus,
    measurementDetail,
    measurementDetailErrorMessage,
    formStatus,
    formResponseData,
    formErrorMessage,
  ];
}
