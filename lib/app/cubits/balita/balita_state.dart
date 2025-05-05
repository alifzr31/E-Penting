part of 'balita_cubit.dart';

enum BalitaStatus { initial, loading, success, error }

enum CheckNikStatus { initial, loading, success, error }

enum DetailStatus { initial, loading, success, error }

enum FormStatus { initial, loading, success, error }

class BalitaState extends Equatable {
  final BalitaStatus balitaStatus;
  final bool hasMoreBalita;
  final List<Balita> balitas;
  final dynamic balitaError;
  final String selectedFilter;
  final CheckNikStatus checkNikStatus;
  final String? checkNikMessage;
  final dynamic checkNikError;
  final FormStatus formStatus;
  final Response? formResponse;
  final dynamic formError;
  final DetailStatus detailStatus;
  final Balita? detailBalita;
  final dynamic detailError;

  const BalitaState({
    this.balitaStatus = BalitaStatus.initial,
    this.hasMoreBalita = true,
    this.balitas = const [],
    this.balitaError,
    this.selectedFilter = 'all',
    this.checkNikStatus = CheckNikStatus.initial,
    this.checkNikMessage,
    this.checkNikError,
    this.formStatus = FormStatus.initial,
    this.formResponse,
    this.formError,
    this.detailStatus = DetailStatus.initial,
    this.detailBalita,
    this.detailError,
  });

  BalitaState copyWith({
    BalitaStatus? balitaStatus,
    bool? hasMoreBalita,
    List<Balita>? balitas,
    dynamic balitaError,
    String? selectedFilter,
    CheckNikStatus? checkNikStatus,
    String? checkNikMessage,
    dynamic checkNikError,
    FormStatus? formStatus,
    Response? formResponse,
    dynamic formError,
    DetailStatus? detailStatus,
    Balita? detailBalita,
    dynamic detailError,
  }) {
    return BalitaState(
      balitaStatus: balitaStatus ?? this.balitaStatus,
      hasMoreBalita: hasMoreBalita ?? this.hasMoreBalita,
      balitas: balitas ?? this.balitas,
      balitaError: balitaError ?? this.balitaError,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      checkNikStatus: checkNikStatus ?? this.checkNikStatus,
      checkNikMessage: checkNikMessage,
      checkNikError: checkNikError ?? this.checkNikError,
      formStatus: formStatus ?? this.formStatus,
      formResponse: formResponse,
      formError: formError ?? this.formError,
      detailStatus: detailStatus ?? this.detailStatus,
      detailBalita: detailBalita,
      detailError: detailError ?? this.detailError,
    );
  }

  @override
  List<Object?> get props => [
    balitaStatus,
    hasMoreBalita,
    balitas,
    balitaError,
    selectedFilter,
    checkNikStatus,
    checkNikMessage,
    checkNikError,
    formStatus,
    formResponse,
    formError,
    detailStatus,
    detailBalita,
    detailError,
  ];
}
