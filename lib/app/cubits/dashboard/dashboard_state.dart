part of 'dashboard_cubit.dart';

enum PercentageStatus { initial, loading, success, error }

enum LatestBalitaStatus { initial, loading, success, error }

enum LatestPengukuranStatus { initial, loading, success, error }

enum LatestImunisasiStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final String greeting;
  final PercentageStatus percentageStatus;
  final List<Percentage> percentages;
  final dynamic percentageError;
  final LatestBalitaStatus latestBalitaStatus;
  final List<Balita> latestBalitas;
  final dynamic latestBalitaError;
  final LatestPengukuranStatus latestPengukuranStatus;
  final List<Pengukuran> latestPengukurans;
  final dynamic latestPengukuranError;
  final LatestImunisasiStatus latestImunisasiStatus;
  final List<Imunisasi> latestImunisasis;
  final dynamic latestImunisasiError;

  const DashboardState({
    this.greeting = '',
    this.percentageStatus = PercentageStatus.initial,
    this.percentages = const [],
    this.percentageError,
    this.latestBalitaStatus = LatestBalitaStatus.initial,
    this.latestBalitas = const [],
    this.latestBalitaError,
    this.latestPengukuranStatus = LatestPengukuranStatus.initial,
    this.latestPengukurans = const [],
    this.latestPengukuranError,
    this.latestImunisasiStatus = LatestImunisasiStatus.initial,
    this.latestImunisasis = const [],
    this.latestImunisasiError,
  });

  DashboardState copyWith({
    String? greeting,
    PercentageStatus? percentageStatus,
    List<Percentage>? percentages,
    dynamic percentageError,
    LatestBalitaStatus? latestBalitaStatus,
    List<Balita>? latestBalitas,
    dynamic latestBalitaError,
    LatestPengukuranStatus? latestPengukuranStatus,
    List<Pengukuran>? latestPengukurans,
    dynamic latestPengukuranError,
    LatestImunisasiStatus? latestImunisasiStatus,
    List<Imunisasi>? latestImunisasis,
    dynamic latestImunisasiError,
  }) {
    return DashboardState(
      greeting: greeting ?? this.greeting,
      percentageStatus: percentageStatus ?? this.percentageStatus,
      percentages: percentages ?? this.percentages,
      percentageError: percentageError ?? this.percentageError,
      latestBalitaStatus: latestBalitaStatus ?? this.latestBalitaStatus,
      latestBalitas: latestBalitas ?? this.latestBalitas,
      latestBalitaError: latestBalitaError ?? this.latestBalitaError,
      latestPengukuranStatus:
          latestPengukuranStatus ?? this.latestPengukuranStatus,
      latestPengukurans: latestPengukurans ?? this.latestPengukurans,
      latestPengukuranError:
          latestPengukuranError ?? this.latestPengukuranError,
      latestImunisasiStatus:
          latestImunisasiStatus ?? this.latestImunisasiStatus,
      latestImunisasis: latestImunisasis ?? this.latestImunisasis,
      latestImunisasiError: latestImunisasiError ?? this.latestImunisasiError,
    );
  }

  @override
  List<Object?> get props => [
    greeting,
    percentageStatus,
    percentages,
    percentageError,
    latestBalitaStatus,
    latestBalitas,
    latestBalitaError,
    latestPengukuranStatus,
    latestPengukurans,
    latestPengukuranError,
    latestImunisasiStatus,
    latestImunisasis,
    latestImunisasiError,
  ];
}
