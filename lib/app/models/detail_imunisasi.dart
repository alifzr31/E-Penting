// To parse this JSON data, do
//
//     final detailImunisasi = detailImunisasiFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

DetailImunisasi detailImunisasiFromJson(dynamic data) =>
    DetailImunisasi.fromJson(data);

String detailImunisasiToJson(DetailImunisasi data) =>
    json.encode(data.toJson());

class DetailImunisasi extends Equatable {
  final int? id;
  final String? nikAnak;
  final String? namaAnak;
  final DateTime? tanggalLahir;
  final ImunisasiType? imunisasi;

  const DetailImunisasi({
    this.id,
    this.nikAnak,
    this.namaAnak,
    this.tanggalLahir,
    this.imunisasi,
  });

  @override
  List<Object?> get props => [id, nikAnak, namaAnak, tanggalLahir, imunisasi];

  factory DetailImunisasi.fromJson(Map<String, dynamic> json) =>
      DetailImunisasi(
        id: json["id"],
        nikAnak: json["nik_anak"],
        namaAnak: json["nama_anak"],
        tanggalLahir:
            json["tanggal_lahir"] == null
                ? null
                : DateTime.parse(json["tanggal_lahir"]),
        imunisasi:
            json["imunisasi"] == null
                ? null
                : ImunisasiType.fromJson(json["imunisasi"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nik_anak": nikAnak,
    "nama_anak": namaAnak,
    "tanggal_lahir":
        "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
    "imunisasi": imunisasi?.toJson(),
  };
}

class ImunisasiType extends Equatable {
  final int? id;
  final int? identitasId;
  final DateTime? tanggalImunisasi;
  final int? hb;
  final int? dptHb1;
  final int? dptHb2;
  final int? dptHb3;
  final int? dptHbl;
  final int? polio1;
  final int? polio2;
  final int? polio3;
  final int? polio4;
  final int? campak;
  final int? campakL;
  final int? bcg;
  final int? ipv1;
  final int? ipv2;
  final int? rotav1;
  final int? rotav2;
  final int? rotav3;
  final int? pcv1;
  final int? pcv2;
  final int? pcv3;

  const ImunisasiType({
    this.id,
    this.identitasId,
    this.tanggalImunisasi,
    this.hb,
    this.dptHb1,
    this.dptHb2,
    this.dptHb3,
    this.dptHbl,
    this.polio1,
    this.polio2,
    this.polio3,
    this.polio4,
    this.campak,
    this.campakL,
    this.bcg,
    this.ipv1,
    this.ipv2,
    this.rotav1,
    this.rotav2,
    this.rotav3,
    this.pcv1,
    this.pcv2,
    this.pcv3,
  });

  @override
  List<Object?> get props => [
    id,
    identitasId,
    tanggalImunisasi,
    hb,
    dptHb1,
    dptHb2,
    dptHb3,
    dptHbl,
    polio1,
    polio2,
    polio3,
    polio4,
    campak,
    campakL,
    bcg,
    ipv1,
    ipv2,
    rotav1,
    rotav2,
    rotav3,
    pcv1,
    pcv2,
    pcv3,
  ];

  factory ImunisasiType.fromJson(Map<String, dynamic> json) => ImunisasiType(
    id: json["id"],
    identitasId: json["identitas_id"],
    tanggalImunisasi:
        json["tanggal_imunisasi"] == null
            ? null
            : DateTime.parse(json["tanggal_imunisasi"]),
    hb: json["hb"],
    dptHb1: json["dpt_hb1"],
    dptHb2: json["dpt_hb2"],
    dptHb3: json["dpt_hb3"],
    dptHbl: json["dpt_hbl"],
    polio1: json["polio1"],
    polio2: json["polio2"],
    polio3: json["polio3"],
    polio4: json["polio4"],
    campak: json["campak"],
    campakL: json["campak_l"],
    bcg: json["bcg"],
    ipv1: json["ipv_1"],
    ipv2: json["ipv_2"],
    rotav1: json["rotav_1"],
    rotav2: json["rotav_2"],
    rotav3: json["rotav_3"],
    pcv1: json["pcv_1"],
    pcv2: json["pcv_2"],
    pcv3: json["pcv_3"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "identitas_id": identitasId,
    "tanggal_imunisasi":
        "${tanggalImunisasi!.year.toString().padLeft(4, '0')}-${tanggalImunisasi!.month.toString().padLeft(2, '0')}-${tanggalImunisasi!.day.toString().padLeft(2, '0')}",
    "hb": hb,
    "dpt_hb1": dptHb1,
    "dpt_hb2": dptHb2,
    "dpt_hb3": dptHb3,
    "dpt_hbl": dptHbl,
    "polio1": polio1,
    "polio2": polio2,
    "polio3": polio3,
    "polio4": polio4,
    "campak": campak,
    "campak_l": campakL,
    "bcg": bcg,
    "ipv_1": ipv1,
    "ipv_2": ipv2,
    "rotav_1": rotav1,
    "rotav_2": rotav2,
    "rotav_3": rotav3,
    "pcv_1": pcv1,
    "pcv_2": pcv2,
    "pcv_3": pcv3,
  };
}
