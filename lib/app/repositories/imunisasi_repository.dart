import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/services/imunisasi_service.dart';

abstract class ImunisasiRepository {
  Future<List<Imunisasi>> fetchAllImunisasi({int? page, int? month, int? year});
  Future<List<Imunisasi>> fetchSearchImunisasi({String? name});
}

class ImunisasiRepositoryImpl implements ImunisasiRepository {
  final ImunisasiService _service;

  ImunisasiRepositoryImpl(this._service);

  @override
  Future<List<Imunisasi>> fetchAllImunisasi({
    int? page,
    int? month,
    int? year,
  }) async {
    return await _service.fetchAllImunisasi(
      page: page,
      month: month,
      year: year,
    );
  }

  @override
  Future<List<Imunisasi>> fetchSearchImunisasi({String? name}) async {
    return await _service.fetchSearchImunisasi(name: name);
  }
}
