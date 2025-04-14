part of 'pengukuran_cubit.dart';

enum PengukuranStatus { initial, loading, success, error }

enum DetailStatus { initial, loading, success, error }

enum FormStatus { initial, loading, success, error }

class PengukuranState extends Equatable {
  final PengukuranStatus pengukuranStatus;
  final bool hasMorePengukuran;
  final List<Pengukuran> pengukurans;
  final dynamic pengukuranError;
  final DetailStatus detailStatus;
  final DetailPengukuran? detailPengukuran;
  final dynamic detailError;
  final FormStatus formStatus;
  final Response? formResponse;
  final dynamic formError;

  const PengukuranState({
    this.pengukuranStatus = PengukuranStatus.initial,
    this.hasMorePengukuran = true,
    this.pengukurans = const [],
    this.pengukuranError,
    this.detailStatus = DetailStatus.initial,
    this.detailPengukuran,
    this.detailError,
    this.formStatus = FormStatus.initial,
    this.formResponse,
    this.formError,
  });

  PengukuranState copyWith({
    PengukuranStatus? pengukuranStatus,
    bool? hasMorePengukuran,
    List<Pengukuran>? pengukurans,
    dynamic pengukuranError,
    DetailStatus? detailStatus,
    DetailPengukuran? detailPengukuran,
    dynamic detailError,
    FormStatus? formStatus,
    Response? formResponse,
    dynamic formError,
  }) {
    return PengukuranState(
      pengukuranStatus: pengukuranStatus ?? this.pengukuranStatus,
      hasMorePengukuran: hasMorePengukuran ?? this.hasMorePengukuran,
      pengukurans: pengukurans ?? this.pengukurans,
      pengukuranError: pengukuranError ?? this.pengukuranError,
      detailStatus: detailStatus ?? this.detailStatus,
      detailPengukuran: detailPengukuran,
      detailError: detailError ?? this.detailError,
      formStatus: formStatus ?? this.formStatus,
      formResponse: formResponse,
      formError: formError ?? this.formError,
    );
  }

  @override
  List<Object?> get props => [
    pengukuranStatus,
    hasMorePengukuran,
    pengukurans,
    pengukuranError,
    detailStatus,
    detailPengukuran,
    detailError,
    formStatus,
    formResponse,
    formError,
  ];
}
