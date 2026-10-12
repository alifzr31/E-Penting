// To parse this JSON data, do
//
//     final heightMeasurementGraphNik = heightMeasurementGraphNikFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MeasurementGraphNik measurementGraphNikFromJson(dynamic data) =>
    MeasurementGraphNik.fromJson(data);

String measurementGraphNikToJson(MeasurementGraphNik data) =>
    json.encode(data.toJson());

class MeasurementGraphNik extends Equatable {
  final List<String>? labels;
  final List<double>? datas;

  const MeasurementGraphNik({this.labels, this.datas});

  @override
  List<Object?> get props => [labels, datas];

  factory MeasurementGraphNik.fromJson(Map<String, dynamic> json) =>
      MeasurementGraphNik(
        labels: json["labels"] == null
            ? []
            : List<String>.from(json["labels"]!.map((x) => x)),
        datas: json["data"] == null
            ? []
            : List<double>.from(json["data"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
    "labels": labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
    "data": datas == null ? [] : List<dynamic>.from(datas!.map((x) => x)),
  };
}
