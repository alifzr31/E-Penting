// To parse this JSON data, do
//
//     final measurement = measurementFromJson(jsonString);

// To parse this JSON data, do
//
//     final measurement = measurementFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Measurement measurementFromJson(String str) =>
    Measurement.fromJson(json.decode(str));

String measurementToJson(Measurement data) => json.encode(data.toJson());

List<Measurement> listMeasurementFromJson(dynamic data) =>
    data.map<Measurement>((x) => Measurement.fromJson(x)).toList();

String listMeasurementToJson(List<Measurement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Measurement extends Equatable {
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

  const Measurement({
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

  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
    idPengukuran: json["id_pengukuran"],
    hari: json["hari"],
    tanggalPenimbangan: json["tanggal_penimbangan"],
    namaAnak: json["nama_anak"],
    jenisKelamin: json["jenis_kelamin"],
    umurBulan: json["umur_bulan"],
    berat: json["berat"]?.toDouble(),
    tinggi: json["tinggi"]?.toDouble(),
    stanting: json["stanting"],
    beratBadan: json["berat_badan"],
    statusGizi: json["status_gizi"],
  );

  Map<String, dynamic> toJson() => {
    "id_pengukuran": idPengukuran,
    "hari": hari,
    "tanggal_penimbangan": tanggalPenimbangan,
    "nama_anak": namaAnak,
    "jenis_kelamin": jenisKelamin,
    "umur_bulan": umurBulan,
    "berat": berat,
    "tinggi": tinggi,
    "stanting": stanting,
    "berat_badan": beratBadan,
    "status_gizi": statusGizi,
  };
}
