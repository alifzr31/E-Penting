part of 'imunisasi_cubit.dart';

enum ImunisasiStatus { initial, loading, success, error }

enum DetailStatus { initial, loading, success, error }

enum FormStatus { initial, loading, success, error }

class ImunisasiState extends Equatable {
  final ImunisasiStatus imunisasiStatus;
  final bool hasMoreImunisasi;
  final List<Imunisasi> imunisasis;
  final dynamic imunisasiError;
  final DetailStatus detailStatus;
  final DetailImunisasi? detailImunisasi;
  final dynamic detailError;
  final FormStatus formStatus;
  final Response? formResponse;
  final dynamic formError;

  const ImunisasiState({
    this.imunisasiStatus = ImunisasiStatus.initial,
    this.hasMoreImunisasi = true,
    this.imunisasis = const [],
    this.imunisasiError,
    this.detailStatus = DetailStatus.initial,
    this.detailImunisasi,
    this.detailError,
    this.formStatus = FormStatus.initial,
    this.formResponse,
    this.formError,
  });

  ImunisasiState copyWith({
    ImunisasiStatus? imunisasiStatus,
    bool? hasMoreImunisasi,
    List<Imunisasi>? imunisasis,
    dynamic imunisasiError,
    DetailStatus? detailStatus,
    DetailImunisasi? detailImunisasi,
    dynamic detailError,
    FormStatus? formStatus,
    Response? formResponse,
    dynamic formError,
  }) {
    return ImunisasiState(
      imunisasiStatus: imunisasiStatus ?? this.imunisasiStatus,
      hasMoreImunisasi: hasMoreImunisasi ?? this.hasMoreImunisasi,
      imunisasis: imunisasis ?? this.imunisasis,
      imunisasiError: imunisasiError ?? this.imunisasiError,
      detailStatus: detailStatus ?? this.detailStatus,
      detailImunisasi: detailImunisasi,
      detailError: detailError ?? this.detailError,
      formStatus: formStatus ?? this.formStatus,
      formResponse: formResponse,
      formError: formError ?? this.formError,
    );
  }

  @override
  List<Object?> get props => [
    imunisasiStatus,
    hasMoreImunisasi,
    imunisasis,
    imunisasiError,
    detailStatus,
    detailImunisasi,
    detailError,
    formStatus,
    formResponse,
    formError,
  ];
}
