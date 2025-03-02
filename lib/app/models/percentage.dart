// To parse this JSON data, do
//
//     final percentage = percentageFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Percentage percentageFromJson(dynamic data) => Percentage.fromJson(data);

String percentageToJson(Percentage data) => json.encode(data.toJson());

List<Percentage> listPercentageFromJson(dynamic data) =>
    data.map<Percentage>((x) => Percentage.fromJson(x)).toList();

String listPercentageToJson(List<Percentage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Percentage extends Equatable {
  final String? jenisKelamin;
  final int? total;
  final double? percentage;

  const Percentage({this.jenisKelamin, this.total, this.percentage});

  @override
  List<Object?> get props => [jenisKelamin, total, percentage];

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
    jenisKelamin: json["jenis_kelamin"],
    total: json["total"],
    percentage: json["percentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "jenis_kelamin": jenisKelamin,
    "total": total,
    "percentage": percentage,
  };
}
