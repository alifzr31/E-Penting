// To parse this JSON data, do
//
//     final balita = balitaFromJson(jsonString);

import 'dart:convert';

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
  final String? jenisKelamin;
  final int? anakKe;
  final int? tinggi;
  final double? beratLahir;
  final DateTime? tanggalLahir;
  final int? bulanUsia;
  final int? posyandu;

  const Balita({
    this.id,
    this.nikAnak,
    this.namaAnak,
    this.jenisKelamin,
    this.anakKe,
    this.tinggi,
    this.beratLahir,
    this.tanggalLahir,
    this.bulanUsia,
    this.posyandu,
  });

  @override
  List<Object?> get props => [
    id,
    nikAnak,
    namaAnak,
    jenisKelamin,
    anakKe,
    tinggi,
    beratLahir,
    tanggalLahir,
    bulanUsia,
    posyandu,
  ];

  factory Balita.fromJson(Map<String, dynamic> json) => Balita(
    id: json["id"],
    nikAnak: json["nik_anak"],
    namaAnak: json["nama_anak"],
    jenisKelamin: json["jenis_kelamin"],
    anakKe: json["anak_ke"],
    tinggi: json["tinggi"],
    beratLahir: json["berat_lahir"]?.toDouble(),
    tanggalLahir:
        json["tanggal_lahir"] == null
            ? null
            : DateTime.parse(json["tanggal_lahir"]),
    bulanUsia: json["bulan_usia"],
    posyandu: json["posyandu"],
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
