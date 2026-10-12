// To parse this JSON data, do
//
//     final toddler = toddlerFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Toddler toddlerFromJson(dynamic data) => Toddler.fromJson(data);

String toddlerToJson(Toddler data) => json.encode(data.toJson());

List<Toddler> listToddlerFromJson(dynamic data) =>
    data.map<Toddler>((x) => Toddler.fromJson(x)).toList();

String listToddlerToJson(List<Toddler> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Toddler extends Equatable {
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
  final String? namaKecamatan;
  final String? namaKelurahan;
  final String? namaPuskesmas;
  final String? alamat;
  final String? rt;
  final String? rw;
  final int? kecamatan;
  final int? kelurahan;
  final int? puskesmas;
  final int? posyandu;
  final bool? kia;
  final bool? imd;
  final bool? pendudukKotaBandung;
  final double? lingkarKepalaLahir;
  final int? usiaKehamilan;
  final bool? kiaBayiKecil;

  const Toddler({
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
    this.namaKecamatan,
    this.namaKelurahan,
    this.namaPuskesmas,
    this.alamat,
    this.rt,
    this.rw,
    this.kecamatan,
    this.kelurahan,
    this.puskesmas,
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
    namaKecamatan,
    namaKelurahan,
    namaPuskesmas,
    alamat,
    rt,
    rw,
    kecamatan,
    kelurahan,
    puskesmas,
    posyandu,
    kia,
    imd,
    pendudukKotaBandung,
    lingkarKepalaLahir,
    usiaKehamilan,
    kiaBayiKecil,
  ];

  factory Toddler.fromJson(Map<String, dynamic> json) => Toddler(
    id: json["id"],
    nikAnak: json["nik_anak"],
    namaAnak: json["nama_anak"],
    anakKe: json["anak_ke"],
    jenisKelamin: json["jenis_kelamin"],
    tanggalLahir: json["tanggal_lahir"] == null
        ? null
        : .parse((json["tanggal_lahir"] as String).trim()),
    bulanUsia: json["bulan_usia"],
    tinggi: json["tinggi"]?.toDouble(),
    beratLahir: json["berat_lahir"]?.toDouble(),
    noKk: json["nomor_kk"] ?? json["no_kk"],
    nikAyah: json["nik_ayah"],
    namaAyah: json["nama_ayah"],
    nomorTelepon: json["nomor_telepon"],
    provinsi: json["provinsi"],
    kota: json["kota"],
    namaKecamatan: json["nama_kecamatan"],
    namaKelurahan: json["nama_kelurahan"],
    namaPuskesmas: json["nama_puskesmas"],
    alamat: json["alamat"],
    rt: json["rt"],
    rw: json["rw"],
    kecamatan: json["kecamatan"],
    kelurahan: json["kelurahan"],
    puskesmas: json["puskesmas"],
    posyandu: json["posyandu"],
    kia: json["kia"] == null
        ? null
        : json["kia"] == 1
        ? true
        : false,
    imd: json["imd"] == null
        ? null
        : json["imd"] == 1
        ? true
        : false,
    pendudukKotaBandung: json["penduduk_kota_bandung"] == null
        ? null
        : json["penduduk_kota_bandung"] == 1
        ? true
        : false,
    lingkarKepalaLahir: json["lingkar_kepala_lahir"]?.toDouble(),
    usiaKehamilan: json["usia_kehamilan"],
    kiaBayiKecil: json["kia_bayi_kecil"] == null
        ? null
        : json["kia_bayi_kecil"] == 1
        ? true
        : false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nik_anak": nikAnak,
    "nama_anak": namaAnak,
    "anak_ke": anakKe,
    "jenis_kelamin": jenisKelamin,
    "tanggal_lahir": tanggalLahir == null
        ? null
        : "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
    "bulan_usia": bulanUsia,
    "tinggi": tinggi,
    "berat_lahir": beratLahir,
    "no_kk": noKk,
    "nik_ayah": nikAyah,
    "nama_ayah": namaAyah,
    "nomor_telepon": nomorTelepon,
    "provinsi": provinsi,
    "kota": kota,
    "alamat": alamat,
    "rt": rt,
    "rw": rw,
    "posyandu": posyandu,
    "kia": kia,
    "imd": imd,
    "penduduk_kota_bandung": pendudukKotaBandung,
    "lingkar_kepala_lahir": lingkarKepalaLahir,
    "usia_kehamilan": usiaKehamilan,
    "kia_bayi_kecil": kiaBayiKecil,
  };
}
