part of 'pengukuran_cubit.dart';

enum PengukuranStatus { initial, loading, success, error }

class PengukuranState extends Equatable {
  final PengukuranStatus pengukuranStatus;
  final bool hasMorePengukuran;
  final List<Pengukuran> pengukurans;
  final dynamic pengukuranError;

  const PengukuranState({
    this.pengukuranStatus = PengukuranStatus.initial,
    this.hasMorePengukuran = true,
    this.pengukurans = const [],
    this.pengukuranError,
  });

  PengukuranState copyWith({
    PengukuranStatus? pengukuranStatus,
    bool? hasMorePengukuran,
    List<Pengukuran>? pengukurans,
    dynamic pengukuranError,
  }) {
    return PengukuranState(
      pengukuranStatus: pengukuranStatus ?? this.pengukuranStatus,
      hasMorePengukuran: hasMorePengukuran ?? this.hasMorePengukuran,
      pengukurans: pengukurans ?? this.pengukurans,
      pengukuranError: pengukuranError ?? this.pengukuranError,
    );
  }

  @override
  List<Object?> get props => [
    pengukuranStatus,
    hasMorePengukuran,
    pengukurans,
    pengukuranError,
  ];
}
