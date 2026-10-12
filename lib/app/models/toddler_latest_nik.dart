// To parse this JSON data, do
//
//     final toddleLatestNik = toddleLatestNikFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ToddlerLatestNik toddlerLatestNikFromJson(dynamic data) =>
    ToddlerLatestNik.fromJson(data);

String toddlerLatestNikToJson(ToddlerLatestNik data) =>
    json.encode(data.toJson());

class ToddlerLatestNik extends Equatable {
  final Pengukuran? pengukuran;
  final Imunisasi? imunisasi;

  const ToddlerLatestNik({this.pengukuran, this.imunisasi});

  @override
  List<Object?> get props => [pengukuran, imunisasi];

  factory ToddlerLatestNik.fromJson(Map<String, dynamic> json) =>
      ToddlerLatestNik(
        pengukuran: json["pengukuran"] == null
            ? null
            : Pengukuran.fromJson(json["pengukuran"]),
        imunisasi: json["imunisasi"] == null
            ? null
            : Imunisasi.fromJson(json["imunisasi"]),
      );

  Map<String, dynamic> toJson() => {
    "pengukuran": pengukuran?.toJson(),
    "imunisasi": imunisasi?.toJson(),
  };
}

class Imunisasi extends Equatable {
  final DateTime? tanggalImunisasi;
  final List<String>? list;
  final List<String>? listBelum;

  const Imunisasi({this.tanggalImunisasi, this.list, this.listBelum});

  @override
  List<Object?> get props => [tanggalImunisasi, list, listBelum];

  factory Imunisasi.fromJson(Map<String, dynamic> json) => Imunisasi(
    tanggalImunisasi: json["tanggal_imunisasi"] == null
        ? null
        : .parse(json["tanggal_imunisasi"]),
    list: json["list"] == null
        ? []
        : List<String>.from(json["list"]!.map((x) => x)),
    listBelum: json["list_belum"] == null
        ? []
        : List<String>.from(json["list_belum"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tanggal_imunisasi": tanggalImunisasi == null
        ? null
        : "${tanggalImunisasi!.year.toString().padLeft(4, '0')}-${tanggalImunisasi!.month.toString().padLeft(2, '0')}-${tanggalImunisasi!.day.toString().padLeft(2, '0')}",
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x)),
    "list_belum": listBelum == null
        ? []
        : List<dynamic>.from(listBelum!.map((x) => x)),
  };
}

class Pengukuran extends Equatable {
  final DateTime? tanggalUkur;
  final double? berat;
  final double? tinggi;
  final double? lingkarKepala;

  const Pengukuran({
    this.tanggalUkur,
    this.berat,
    this.tinggi,
    this.lingkarKepala,
  });

  @override
  List<Object?> get props => [tanggalUkur, berat, tinggi, lingkarKepala];

  factory Pengukuran.fromJson(Map<String, dynamic> json) => Pengukuran(
    tanggalUkur: json["tanggal_ukur"] == null
        ? null
        : .parse(json["tanggal_ukur"]),
    berat: json["berat"]?.toDouble(),
    tinggi: json["tinggi"]?.toDouble(),
    lingkarKepala: json["lingkar_kepala"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "tanggal_ukur": tanggalUkur == null
        ? null
        : "${tanggalUkur!.year.toString().padLeft(4, '0')}-${tanggalUkur!.month.toString().padLeft(2, '0')}-${tanggalUkur!.day.toString().padLeft(2, '0')}",
    "berat": berat,
    "tinggi": tinggi,
    "lingkar_kepala": lingkarKepala,
  };
}
