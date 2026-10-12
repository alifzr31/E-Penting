// To parse this JSON data, do
//
//     final immunization = immunizationFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Immunization immunizationFromJson(dynamic data) => Immunization.fromJson(data);

String immunizationToJson(Immunization data) => json.encode(data.toJson());

List<Immunization> listImmunizationFromJson(dynamic data) =>
    data.map<Immunization>((x) => Immunization.fromJson(x)).toList();

String listImmunizationToJson(List<Immunization> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Immunization extends Equatable {
  final int? idImunisasi;
  final String? hari;
  final String? tanggalImunisasi;
  final String? namaAnak;
  final String? jenisKelamin;
  final int? umurBulan;

  const Immunization({
    this.idImunisasi,
    this.hari,
    this.tanggalImunisasi,
    this.namaAnak,
    this.jenisKelamin,
    this.umurBulan,
  });

  @override
  List<Object?> get props => [
    idImunisasi,
    hari,
    tanggalImunisasi,
    namaAnak,
    jenisKelamin,
    umurBulan,
  ];

  factory Immunization.fromJson(Map<String, dynamic> json) => Immunization(
    idImunisasi: json["id_imunisasi"],
    hari: json["hari"],
    tanggalImunisasi: json["tanggal_imunisasi"],
    namaAnak: json["nama_anak"],
    jenisKelamin: json["jenis_kelamin"],
    umurBulan: json["umur_bulan"],
  );

  Map<String, dynamic> toJson() => {
    "id_imunisasi": idImunisasi,
    "hari": hari,
    "tanggal_imunisasi": tanggalImunisasi,
    "nama_anak": namaAnak,
    "jenis_kelamin": jenisKelamin,
    "umur_bulan": umurBulan,
  };
}
