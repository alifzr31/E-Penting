import 'package:epenting/app/models/history_pengukuran.dart';
import 'package:epenting/app/models/latest_pengukuran.dart';
import 'package:epenting/app/models/latest_vaccine.dart';
import 'package:epenting/app/services/ortu_service.dart';

abstract class OrtuRepository {
  Future<LatestPengukuran?> fetchLatestPengukuranBalita({String? nik});
  Future<List<LatestVaccine>> fetchLatestVaccine({String? nik});
  Future<List<HistoryPengukuran>> fetchHistoryPengukuran({String? nik});
}

class OrtuRepositoryImpl implements OrtuRepository {
  final OrtuService _service;

  OrtuRepositoryImpl(this._service);

  @override
  Future<LatestPengukuran?> fetchLatestPengukuranBalita({String? nik}) async {
    return await _service.fetchLatestPengukuranBalita(nik: nik);
  }

  @override
  Future<List<LatestVaccine>> fetchLatestVaccine({String? nik}) async {
    return await _service.fetchLatestVaccine(nik: nik);
  }

  @override
  Future<List<HistoryPengukuran>> fetchHistoryPengukuran({String? nik}) async {
    return await _service.fetchHistoryPengukuran(nik: nik);
  }
}
