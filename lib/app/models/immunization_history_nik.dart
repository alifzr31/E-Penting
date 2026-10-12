// To parse this JSON data, do
//
//     final immunizationHistoryNik = immunizationHistoryNikFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ImmunizationHistoryNik immunizationHistoryNikFromJson(dynamic data) =>
    ImmunizationHistoryNik.fromJson(data);

String immunizationHistoryNikToJson(ImmunizationHistoryNik data) =>
    json.encode(data.toJson());

List<ImmunizationHistoryNik> listImmunizationHistoryNikFromJson(dynamic data) =>
    data
        .map<ImmunizationHistoryNik>((x) => ImmunizationHistoryNik.fromJson(x))
        .toList();

String listImmunizationHistoryNikToJson(List<ImmunizationHistoryNik> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImmunizationHistoryNik extends Equatable {
  final DateTime? tanggalImunisasi;
  final List<String>? imunisasi;

  const ImmunizationHistoryNik({this.tanggalImunisasi, this.imunisasi});

  @override
  List<Object?> get props => [tanggalImunisasi, imunisasi];

  factory ImmunizationHistoryNik.fromJson(Map<String, dynamic> json) =>
      ImmunizationHistoryNik(
        tanggalImunisasi: json["tanggal_imunisasi"] == null
            ? null
            : .parse(json["tanggal_imunisasi"]),
        imunisasi: json["imunisasi"] == null
            ? []
            : List<String>.from(json["imunisasi"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "tanggal_imunisasi": tanggalImunisasi == null
        ? null
        : "${tanggalImunisasi!.year.toString().padLeft(4, '0')}-${tanggalImunisasi!.month.toString().padLeft(2, '0')}-${tanggalImunisasi!.day.toString().padLeft(2, '0')}",
    "imunisasi": imunisasi == null
        ? []
        : List<dynamic>.from(imunisasi!.map((x) => x)),
  };
}
