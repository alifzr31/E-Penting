// To parse this JSON data, do
//
//     final imunisasi = imunisasiFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Imunisasi imunisasiFromJson(dynamic data) => Imunisasi.fromJson(data);

String imunisasiToJson(Imunisasi data) => json.encode(data.toJson());

List<Imunisasi> listImunisasiFromJson(dynamic data) =>
    data.map<Imunisasi>((x) => Imunisasi.fromJson(x)).toList();

String listImunisasiToJson(List<Imunisasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Imunisasi extends Equatable {
  final int? idImunisasi;
  final String? hari;
  final String? tanggalImunisasi;
  final String? namaAnak;
  final String? jenisKelamin;
  final int? umurBulan;

  const Imunisasi({
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

  factory Imunisasi.fromJson(Map<String, dynamic> json) => Imunisasi(
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
