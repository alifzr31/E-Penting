// To parse this JSON data, do
//
//     final pengukuran = pengukuranFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Pengukuran pengukuranFromJson(dynamic data) => Pengukuran.fromJson(data);

String pengukuranToJson(Pengukuran data) => json.encode(data.toJson());

List<Pengukuran> listPengukuranFromJson(dynamic data) =>
    data.map<Pengukuran>((x) => Pengukuran.fromJson(x)).toList();

String listPengukuranToJson(List<Pengukuran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pengukuran extends Equatable {
  final int? idPengukuran;
  final String? jenisKelamin;
  final String? hari;
  final String? tanggalPenimbangan;
  final String? namaAnak;
  final int? umurBulan;
  final double? berat;
  final double? tinggi;
  final String? stanting;
  final String? beratBadan;
  final String? statusGizi;

  const Pengukuran({
    this.idPengukuran,
    this.jenisKelamin,
    this.hari,
    this.tanggalPenimbangan,
    this.namaAnak,
    this.umurBulan,
    this.berat,
    this.tinggi,
    this.stanting,
    this.beratBadan,
    this.statusGizi,
  });

  @override
  List<Object?> get props => [
    idPengukuran,
    jenisKelamin,
    hari,
    tanggalPenimbangan,
    namaAnak,
    umurBulan,
    berat,
    tinggi,
    stanting,
    beratBadan,
    statusGizi,
  ];

  factory Pengukuran.fromJson(Map<String, dynamic> json) => Pengukuran(
    idPengukuran: json["id_pengukuran"],
    jenisKelamin: json["jenis_kelamin"],
    hari: json["hari"],
    tanggalPenimbangan: json["tanggal_penimbangan"],
    namaAnak: json["nama_anak"],
    umurBulan: json["umur_bulan"],
    berat: json["berat"]?.toDouble(),
    tinggi: json["tinggi"]?.toDouble(),
    stanting: json["stanting"],
    beratBadan: json["berat_badan"],
    statusGizi: json["status_gizi"],
  );

  Map<String, dynamic> toJson() => {
    "id_pengukuran": idPengukuran,
    "jenis_kelamin": jenisKelamin,
    "hari": hari,
    "tanggal_penimbangan": tanggalPenimbangan,
    "nama_anak": namaAnak,
    "umur_bulan": umurBulan,
    "berat": berat,
    "tinggi": tinggi,
    "stanting": stanting,
    "berat_badan": beratBadan,
    "status_gizi": statusGizi,
  };
}
