// To parse this JSON data, do
//
//     final latestPengukuran = latestPengukuranFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

LatestPengukuran latestPengukuranFromJson(dynamic data) =>
    LatestPengukuran.fromJson(data);

String latestPengukuranToJson(LatestPengukuran data) =>
    json.encode(data.toJson());

class LatestPengukuran extends Equatable {
  final DateTime? tanggalUkur;
  final double? berat;
  final double? tinggi;
  final int? lingkarKepala;

  const LatestPengukuran({
    this.tanggalUkur,
    this.berat,
    this.tinggi,
    this.lingkarKepala,
  });

  @override
  List<Object?> get props => [tanggalUkur, berat, tinggi, lingkarKepala];

  factory LatestPengukuran.fromJson(Map<String, dynamic> json) =>
      LatestPengukuran(
        tanggalUkur:
            json["tanggal_ukur"] == null
                ? null
                : DateTime.parse(json["tanggal_ukur"]),
        berat: json["berat"]?.toDouble(),
        tinggi: json["tinggi"]?.toDouble(),
        lingkarKepala: json["lingkar_kepala"],
      );

  Map<String, dynamic> toJson() => {
    "tanggal_ukur":
        "${tanggalUkur!.year.toString().padLeft(4, '0')}-${tanggalUkur!.month.toString().padLeft(2, '0')}-${tanggalUkur!.day.toString().padLeft(2, '0')}",
    "berat": berat,
    "tinggi": tinggi,
    "lingkar_kepala": lingkarKepala,
  };
}
