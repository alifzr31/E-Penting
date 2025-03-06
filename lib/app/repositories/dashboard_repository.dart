import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/models/percentage.dart';
import 'package:epenting/app/services/dashboard_service.dart';

abstract class DashboardRepository {
  Future<List<Percentage>> fetchPercentage();
  Future<List<Balita>> fetchLatestBalita();
  Future<List<Pengukuran>> fetchLatestPengukuran();
  Future<List<Imunisasi>> fetchLatestImunisasi();
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardService _service;

  DashboardRepositoryImpl(this._service);

  @override
  Future<List<Percentage>> fetchPercentage() async {
    return await _service.fetchPercentage();
  }

  @override
  Future<List<Balita>> fetchLatestBalita() async {
    return await _service.fetchLatestBalita();
  }

  @override
  Future<List<Pengukuran>> fetchLatestPengukuran() async {
    return await _service.fetchLatestPengukuran();
  }

  @override
  Future<List<Imunisasi>> fetchLatestImunisasi() async {
    return await _service.fetchLatestImunisasi();
  }
}
