// To parse this JSON data, do
//
//     final historyPengukuran = historyPengukuranFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

HistoryPengukuran historyPengukuranFromJson(dynamic data) =>
    HistoryPengukuran.fromJson(data);

String historyPengukuranToJson(HistoryPengukuran data) =>
    json.encode(data.toJson());

List<HistoryPengukuran> listHistoryPengukuranFromJson(dynamic data) =>
    data.map<HistoryPengukuran>((x) => HistoryPengukuran.fromJson(x)).toList();

String listHistoryPengukuranToJson(List<HistoryPengukuran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryPengukuran extends Equatable {
  final DateTime? tanggalUkur;
  final double? berat;
  final double? tinggi;

  const HistoryPengukuran({this.tanggalUkur, this.berat, this.tinggi});

  @override
  List<Object?> get props => [tanggalUkur, berat, tinggi];

  factory HistoryPengukuran.fromJson(Map<String, dynamic> json) =>
      HistoryPengukuran(
        tanggalUkur:
            json["tanggal_ukur"] == null
                ? null
                : DateTime.parse(json["tanggal_ukur"]),
        berat: json["berat"]?.toDouble(),
        tinggi: json["tinggi"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "tanggal_ukur":
        "${tanggalUkur!.year.toString().padLeft(4, '0')}-${tanggalUkur!.month.toString().padLeft(2, '0')}-${tanggalUkur!.day.toString().padLeft(2, '0')}",
    "berat": berat,
    "tinggi": tinggi,
  };
}
