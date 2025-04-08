// To parse this JSON data, do
//
//     final latestVaccine = latestVaccineFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

LatestVaccine latestVaccineFromJson(dynamic data) =>
    LatestVaccine.fromJson(data);

String latestVaccineToJson(LatestVaccine data) => json.encode(data.toJson());

List<LatestVaccine> listLatestVaccineFromJson(dynamic data) =>
    data.map<LatestVaccine>((x) => LatestVaccine.fromJson(x)).toList();

String listLatestVaccineToJson(List<LatestVaccine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestVaccine extends Equatable {
  final DateTime? tanggalImunisasi;
  final List<String>? imunisasi;

  const LatestVaccine({this.tanggalImunisasi, this.imunisasi});

  @override
  List<Object?> get props => [tanggalImunisasi, imunisasi];

  factory LatestVaccine.fromJson(Map<String, dynamic> json) => LatestVaccine(
    tanggalImunisasi:
        json["tanggal_imunisasi"] == null
            ? null
            : DateTime.parse(json["tanggal_imunisasi"]),
    imunisasi:
        json["imunisasi"] == null
            ? []
            : List<String>.from(json["imunisasi"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tanggal_imunisasi":
        "${tanggalImunisasi!.year.toString().padLeft(4, '0')}-${tanggalImunisasi!.month.toString().padLeft(2, '0')}-${tanggalImunisasi!.day.toString().padLeft(2, '0')}",
    "imunisasi":
        imunisasi == null ? [] : List<dynamic>.from(imunisasi!.map((x) => x)),
  };
}
