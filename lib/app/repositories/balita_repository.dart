import 'package:dio/dio.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/services/balita_service.dart';

abstract class BalitaRepository {
  Future<List<Balita>> fetchAllBalita({int? page, String? ageFilter});
  Future<List<Balita>> fetchSearchBalita({String? name});
  Future<String> checkNikBalita({String? nik});
  Future<Response> addBalita({
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  });
  Future<Response> pindahBalita({
    int? idBalita,
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  });
  Future<List<Balita>> fetchSearchPindahBalita({String? name});
  Future<Balita?> fetchDetailBalita({int? balitaId});
  Future<Response> updateBalita({
    int? balitaId,
    String? nikAnak,
    String? noKk,
    String? namaAnak,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepala,
    String? usiaKehamilan,
    bool? kiaBayiKecil,
    int? bukuKia,
    int? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelpOrtu,
    String? alamat,
    String? rt,
    String? rw,
    int? pendudukBandung,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
  });
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

  @override
  Future<String> checkNikBalita({String? nik}) async {
    return await _service.checkNikBalita(nik: nik);
  }

  @override
  Future<Response> addBalita({
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  }) async {
    return await _service.addBalita(
      nik: nik,
      noKk: noKk,
      namaBalita: namaBalita,
      tglLahir: tglLahir,
      jenisKelamin: jenisKelamin,
      anakKe: anakKe,
      beratLahir: beratLahir,
      tinggiLahir: tinggiLahir,
      lingkarKepalaLahir: lingkarKepalaLahir,
      usiaKehamilan: usiaKehamilan,
      kiaBayiKecil: kiaBayiKecil,
      bukuKia: bukuKia,
      imd: imd,
      nikOrtu: nikOrtu,
      namaOrtu: namaOrtu,
      noTelp: noTelp,
      alamat: alamat,
      rt: rt,
      rw: rw,
      idKecamatan: idKecamatan,
      idKelurahan: idKelurahan,
      idPuskesmas: idPuskesmas,
      idPosyandu: idPosyandu,
      pendudukBandung: pendudukBandung,
    );
  }

  @override
  Future<Response> pindahBalita({
    int? idBalita,
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  }) async {
    return await _service.pindahBalita(
      idBalita: idBalita,
      nik: nik,
      noKk: noKk,
      namaBalita: namaBalita,
      tglLahir: tglLahir,
      jenisKelamin: jenisKelamin,
      anakKe: anakKe,
      beratLahir: beratLahir,
      tinggiLahir: tinggiLahir,
      lingkarKepalaLahir: lingkarKepalaLahir,
      usiaKehamilan: usiaKehamilan,
      kiaBayiKecil: kiaBayiKecil,
      bukuKia: bukuKia,
      imd: imd,
      nikOrtu: nikOrtu,
      namaOrtu: namaOrtu,
      noTelp: noTelp,
      alamat: alamat,
      rt: rt,
      rw: rw,
      idKecamatan: idKecamatan,
      idKelurahan: idKelurahan,
      idPuskesmas: idPuskesmas,
      idPosyandu: idPosyandu,
      pendudukBandung: pendudukBandung,
    );
  }

  @override
  Future<List<Balita>> fetchSearchPindahBalita({String? name}) async {
    return await _service.fetchSearchPindahBalita(name: name);
  }

  @override
  Future<Balita?> fetchDetailBalita({int? balitaId}) async {
    return await _service.fetchDetailBalita(balitaId: balitaId);
  }

  @override
  Future<Response> updateBalita({
    int? balitaId,
    String? nikAnak,
    String? noKk,
    String? namaAnak,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepala,
    String? usiaKehamilan,
    bool? kiaBayiKecil,
    int? bukuKia,
    int? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelpOrtu,
    String? alamat,
    String? rt,
    String? rw,
    int? pendudukBandung,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
  }) async {
    return await _service.updateBalita(
      balitaId: balitaId,
      nikAnak: nikAnak,
      noKk: noKk,
      namaAnak: namaAnak,
      tglLahir: tglLahir,
      jenisKelamin: jenisKelamin,
      anakKe: anakKe,
      beratLahir: beratLahir,
      tinggiLahir: tinggiLahir,
      lingkarKepala: lingkarKepala,
      usiaKehamilan: usiaKehamilan,
      kiaBayiKecil: kiaBayiKecil,
      bukuKia: bukuKia,
      imd: imd,
      nikOrtu: nikOrtu,
      namaOrtu: namaOrtu,
      noTelpOrtu: noTelpOrtu,
      alamat: alamat,
      rt: rt,
      rw: rw,
      pendudukBandung: pendudukBandung,
      idKecamatan: idKecamatan,
      idKelurahan: idKelurahan,
      idPuskesmas: idPuskesmas,
      idPosyandu: idPosyandu,
    );
  }
}
