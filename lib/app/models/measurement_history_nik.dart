// To parse this JSON data, do
//
//     final measurementHistoryNik = measurementHistoryNikFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MeasurementHistoryNik measurementHistoryNikFromJson(dynamic data) =>
    MeasurementHistoryNik.fromJson(data);

String measurementHistoryNikToJson(MeasurementHistoryNik data) =>
    json.encode(data.toJson());

List<MeasurementHistoryNik> listMeasurementHistoryNikFromJson(dynamic data) =>
    data
        .map<MeasurementHistoryNik>((x) => MeasurementHistoryNik.fromJson(x))
        .toList();

String listMeasurementHistoryNikToJson(List<MeasurementHistoryNik> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MeasurementHistoryNik extends Equatable {
  final DateTime? tanggalUkur;
  final double? berat;
  final double? tinggi;

  const MeasurementHistoryNik({this.tanggalUkur, this.berat, this.tinggi});

  @override
  List<Object?> get props => [tanggalUkur, berat, tinggi];

  factory MeasurementHistoryNik.fromJson(Map<String, dynamic> json) =>
      MeasurementHistoryNik(
        tanggalUkur: json["tanggal_ukur"] == null
            ? null
            : .parse(json["tanggal_ukur"]),
        berat: json["berat"]?.toDouble(),
        tinggi: json["tinggi"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "tanggal_ukur": tanggalUkur == null
        ? null
        : "${tanggalUkur!.year.toString().padLeft(4, '0')}-${tanggalUkur!.month.toString().padLeft(2, '0')}-${tanggalUkur!.day.toString().padLeft(2, '0')}",
    "berat": berat,
    "tinggi": tinggi,
  };
}
