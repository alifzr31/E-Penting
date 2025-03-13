import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/services/balita_service.dart';

abstract class BalitaRepository {
  Future<List<Balita>> fetchAllBalita({int? page, String? ageFilter});
  Future<List<Balita>> fetchSearchBalita({String? name});
}

class BalitaRepositoryImpl implements BalitaRepository {
  final BalitaService _service;

  BalitaRepositoryImpl(this._service);

  @override
  Future<List<Balita>> fetchAllBalita({int? page, String? ageFilter}) async {
    return await _service.fetchAllBalita(page: page, ageFilter: ageFilter);
  }

  @override
  Future<List<Balita>> fetchSearchBalita({String? name}) async {
    return await _service.fetchSearchBalita(name: name);
  }
}
