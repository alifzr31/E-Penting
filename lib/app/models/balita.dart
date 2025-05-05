// To parse this JSON data, do
//
//     final balita = balitaFromJson(jsonString);

import 'dart:convert';

import 'package:epenting/app/utils/app_helpers.dart';
import 'package:equatable/equatable.dart';

Balita balitaFromJson(dynamic data) => Balita.fromJson(data);

String balitaToJson(Balita data) => json.encode(data.toJson());

List<Balita> listBalitaFromJson(dynamic data) =>
    data.map<Balita>((x) => Balita.fromJson(x)).toList();

String listBalitaToJson(List<Balita> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Balita extends Equatable {
  final int? id;
  final String? nikAnak;
  final String? namaAnak;
  final int? anakKe;
  final String? jenisKelamin;
  final DateTime? tanggalLahir;
  final int? bulanUsia;
  final double? tinggi;
  final double? beratLahir;
  final String? noKk;
  final String? nikAyah;
  final String? namaAyah;
  final String? nomorTelepon;
  final String? provinsi;
  final String? kota;
  final String? alamat;
  final String? rt;
  final String? rw;
  final int? kecamatan;
  final String? namaKecamatan;
  final int? kelurahan;
  final String? namaKelurahan;
  final int? puskesmas;
  final String? namaPuskesmas;
  final int? posyandu;
  final int? kia;
  final int? imd;
  final int? pendudukKotaBandung;
  final double? lingkarKepalaLahir;
  final int? usiaKehamilan;
  final int? kiaBayiKecil;

  const Balita({
    this.id,
    this.nikAnak,
    this.namaAnak,
    this.anakKe,
    this.jenisKelamin,
    this.tanggalLahir,
    this.bulanUsia,
    this.tinggi,
    this.beratLahir,
    this.noKk,
    this.nikAyah,
    this.namaAyah,
    this.nomorTelepon,
    this.provinsi,
    this.kota,
    this.alamat,
    this.rt,
    this.rw,
    this.kecamatan,
    this.namaKecamatan,
    this.kelurahan,
    this.namaKelurahan,
    this.puskesmas,
    this.namaPuskesmas,
    this.posyandu,
    this.kia,
    this.imd,
    this.pendudukKotaBandung,
    this.lingkarKepalaLahir,
    this.usiaKehamilan,
    this.kiaBayiKecil,
  });

  @override
  List<Object?> get props => [
    id,
    nikAnak,
    namaAnak,
    anakKe,
    jenisKelamin,
    tanggalLahir,
    bulanUsia,
    tinggi,
    beratLahir,
    noKk,
    nikAyah,
    namaAyah,
    nomorTelepon,
    provinsi,
    kota,
    alamat,
    rt,
    rw,
    kecamatan,
    namaKecamatan,
    kelurahan,
    namaKelurahan,
    puskesmas,
    namaPuskesmas,
    posyandu,
    kia,
    imd,
    pendudukKotaBandung,
    lingkarKepalaLahir,
    usiaKehamilan,
    kiaBayiKecil,
  ];

  factory Balita.fromJson(Map<String, dynamic> json) => Balita(
    id: json["id"],
    nikAnak: json["nik_anak"],
    namaAnak: json["nama_anak"],
    anakKe: json["anak_ke"],
    jenisKelamin: json["jenis_kelamin"],
    tanggalLahir:
        json["tanggal_lahir"] == null
            ? null
            : !json["tanggal_lahir"].toString().contains('-')
            ? AppHelpers.parseExcelTglLahir(json["tanggal_lahir"].trim())
            : AppHelpers.parseTglLahirFromJson(json["tanggal_lahir"].trim()),
    bulanUsia: json["bulan_usia"],
    tinggi: json["tinggi"]?.toDouble(),
    beratLahir: json["berat_lahir"]?.toDouble(),
    noKk: json["no_kk"] ?? json["nomor_kk"],
    nikAyah: json["nik_ayah"],
    namaAyah: json["nama_ayah"],
    nomorTelepon: json["nomor_telepon"],
    provinsi: json["provinsi"],
    kota: json["kota"],
    alamat: json["alamat"],
    rt: json["rt"],
    rw: json["rw"],
    kecamatan: json["kecamatan"],
    namaKecamatan: json["nama_kecamatan"],
    kelurahan: json["kelurahan"],
    namaKelurahan: json["nama_kelurahan"],
    puskesmas: json["puskesmas"],
    namaPuskesmas: json["nama_puskesmas"],
    posyandu: json["posyandu"],
    kia: json["kia"],
    imd: json["imd"],
    pendudukKotaBandung: json["penduduk_kota_bandung"],
    lingkarKepalaLahir: json["lingkar_kepala_lahir"]?.toDouble(),
    usiaKehamilan: json["usia_kehamilan"],
    kiaBayiKecil: json["kia_bayi_kecil"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nik_anak": nikAnak,
    "nama_anak": namaAnak,
    "jenis_kelamin": jenisKelamin,
    "anak_ke": anakKe,
    "tinggi": tinggi,
    "berat_lahir": beratLahir,
    "tanggal_lahir":
        "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
    "bulan_usia": bulanUsia,
    "posyandu": posyandu,
  };
}
