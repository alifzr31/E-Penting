part of 'imunisasi_cubit.dart';

enum ImunisasiStatus { initial, loading, success, error }

class ImunisasiState extends Equatable {
  final ImunisasiStatus imunisasiStatus;
  final bool hasMoreImunisasi;
  final List<Imunisasi> imunisasis;
  final dynamic imunisasiError;

  const ImunisasiState({
    this.imunisasiStatus = ImunisasiStatus.initial,
    this.hasMoreImunisasi = true,
    this.imunisasis = const [],
    this.imunisasiError,
  });

  ImunisasiState copyWith({
    ImunisasiStatus? imunisasiStatus,
    bool? hasMoreImunisasi,
    List<Imunisasi>? imunisasis,
    dynamic imunisasiError,
  }) {
    return ImunisasiState(
      imunisasiStatus: imunisasiStatus ?? this.imunisasiStatus,
      hasMoreImunisasi: hasMoreImunisasi ?? this.hasMoreImunisasi,
      imunisasis: imunisasis ?? this.imunisasis,
      imunisasiError: imunisasiError ?? this.imunisasiError,
    );
  }

  @override
  List<Object?> get props => [
    imunisasiStatus,
    hasMoreImunisasi,
    imunisasis,
    imunisasiError,
  ];
}
