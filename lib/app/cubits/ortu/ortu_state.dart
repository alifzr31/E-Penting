part of 'ortu_cubit.dart';

enum LatestPengukuranStatus { initial, loading, success, error }

enum LatestVaccineStatus { initial, loading, success, error }

enum HistoryPengukuranStatus { initial, loading, success, error }

class OrtuState extends Equatable {
  final Anak? selectedAnak;
  final LatestPengukuranStatus latestPengukuranStatus;
  final LatestPengukuran? latestPengukuran;
  final dynamic latestPengukuranError;
  final LatestVaccineStatus latestVaccineStatus;
  final List<LatestVaccine> latestVaccines;
  final dynamic latestVaccineError;
  final HistoryPengukuranStatus historyPengukuranStatus;
  final List<HistoryPengukuran> historyPengukurans;
  final dynamic historyPengukuranError;

  const OrtuState({
    this.selectedAnak,
    this.latestPengukuranStatus = LatestPengukuranStatus.initial,
    this.latestPengukuran,
    this.latestPengukuranError,
    this.latestVaccineStatus = LatestVaccineStatus.initial,
    this.latestVaccines = const [],
    this.latestVaccineError,
    this.historyPengukuranStatus = HistoryPengukuranStatus.initial,
    this.historyPengukurans = const [],
    this.historyPengukuranError,
  });

  OrtuState copyWith({
    Anak? selectedAnak,
    LatestPengukuranStatus? latestPengukuranStatus,
    LatestPengukuran? latestPengukuran,
    dynamic latestPengukuranError,
    LatestVaccineStatus? latestVaccineStatus,
    List<LatestVaccine>? latestVaccines,
    dynamic latestVaccineError,
    HistoryPengukuranStatus? historyPengukuranStatus,
    List<HistoryPengukuran>? historyPengukurans,
    dynamic historyPengukuranError,
  }) {
    return OrtuState(
      selectedAnak: selectedAnak ?? this.selectedAnak,
      latestPengukuranStatus:
          latestPengukuranStatus ?? this.latestPengukuranStatus,
      latestPengukuran: latestPengukuran,
      latestPengukuranError:
          latestPengukuranError ?? this.latestPengukuranError,
      latestVaccineStatus: latestVaccineStatus ?? this.latestVaccineStatus,
      latestVaccines: latestVaccines ?? this.latestVaccines,
      latestVaccineError: latestVaccineError ?? this.latestVaccineError,
      historyPengukuranStatus:
          historyPengukuranStatus ?? this.historyPengukuranStatus,
      historyPengukurans: historyPengukurans ?? this.historyPengukurans,
      historyPengukuranError:
          historyPengukuranError ?? this.historyPengukuranError,
    );
  }

  @override
  List<Object?> get props => [
    selectedAnak,
    latestPengukuranStatus,
    latestPengukuran,
    latestPengukuranError,
    latestVaccineStatus,
    latestVaccines,
    latestVaccineError,
    historyPengukuranStatus,
    historyPengukurans,
    historyPengukuranError,
  ];
}
