// To parse this JSON data, do
//
//     final immunizationDetail = immunizationDetailFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ImmunizationDetail immunizationDetailFromJson(dynamic data) =>
    ImmunizationDetail.fromJson(data);

String immunizationDetailToJson(ImmunizationDetail data) =>
    json.encode(data.toJson());

class ImmunizationDetail extends Equatable {
  final int? toddlerId;
  final String? toddlerNik;
  final String? toddlerName;
  final String? toddlerGender;
  final DateTime? toddlerBornDate;
  final int? toddlerMonthAge;
  final String? toddlerParentName;
  final String? toddlerProvince;
  final String? toddlerDistrict;
  final String? toddlerSubDistrict;
  final int? toddlerHealthPost;
  final String? toddlerHealthFacility;
  final String? toddlerAddress;
  final String? toddlerRt;
  final String? toddlerRw;
  final Imunisasi? imunisasi;

  const ImmunizationDetail({
    this.toddlerId,
    this.toddlerNik,
    this.toddlerName,
    this.toddlerGender,
    this.toddlerBornDate,
    this.toddlerMonthAge,
    this.toddlerParentName,
    this.toddlerProvince,
    this.toddlerDistrict,
    this.toddlerSubDistrict,
    this.toddlerHealthPost,
    this.toddlerHealthFacility,
    this.toddlerAddress,
    this.toddlerRt,
    this.toddlerRw,
    this.imunisasi,
  });

  @override
  List<Object?> get props => [
    toddlerId,
    toddlerNik,
    toddlerName,
    toddlerGender,
    toddlerBornDate,
    toddlerMonthAge,
    toddlerParentName,
    toddlerProvince,
    toddlerDistrict,
    toddlerSubDistrict,
    toddlerHealthPost,
    toddlerHealthFacility,
    toddlerAddress,
    toddlerRt,
    toddlerRw,
    imunisasi,
  ];

  factory ImmunizationDetail.fromJson(Map<String, dynamic> json) =>
      ImmunizationDetail(
        toddlerId: json["id"],
        toddlerNik: json["nik_anak"],
        toddlerName: json["nama_anak"],
        toddlerGender: json["jenis_kelamin"],
        toddlerBornDate: json["tanggal_lahir"] == null
            ? null
            : .parse(json["tanggal_lahir"]),
        toddlerMonthAge: json["umur_bulan"],
        toddlerParentName: json["nama_ayah"],
        toddlerProvince: json["provinsi"],
        toddlerDistrict: json["kecamatan"],
        toddlerSubDistrict: json["kelurahan"],
        toddlerHealthPost: json["posyandu"],
        toddlerHealthFacility: json["puskesmas"],
        toddlerAddress: json["alamat"],
        toddlerRt: json["rt"],
        toddlerRw: json["rw"],
        imunisasi: json["imunisasi"] == null
            ? null
            : Imunisasi.fromJson(json["imunisasi"]),
      );

  Map<String, dynamic> toJson() => {
    "id": toddlerId,
    "nik_anak": toddlerNik,
    "nama_anak": toddlerName,
    "jenis_kelamin": toddlerGender,
    "tanggal_lahir": toddlerBornDate == null
        ? null
        : "${toddlerBornDate!.year.toString().padLeft(4, '0')}-${toddlerBornDate!.month.toString().padLeft(2, '0')}-${toddlerBornDate!.day.toString().padLeft(2, '0')}",
    "umur_bulan": toddlerMonthAge,
    "nama_ayah": toddlerParentName,
    "provinsi": toddlerProvince,
    "kecamatan": toddlerDistrict,
    "kelurahan": toddlerSubDistrict,
    "posyandu": toddlerHealthPost,
    "puskesmas": toddlerHealthFacility,
    "alamat": toddlerAddress,
    "rt": toddlerRt,
    "rw": toddlerRw,
    "imunisasi": imunisasi?.toJson(),
  };
}

class Imunisasi extends Equatable {
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

  const Imunisasi({
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

  factory Imunisasi.fromJson(Map<String, dynamic> json) => Imunisasi(
    id: json["id"],
    identitasId: json["identitas_id"],
    tanggalImunisasi: json["tanggal_imunisasi"] == null
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
    "tanggal_imunisasi": tanggalImunisasi == null
        ? null
        : "${tanggalImunisasi!.year.toString().padLeft(4, '0')}-${tanggalImunisasi!.month.toString().padLeft(2, '0')}-${tanggalImunisasi!.day.toString().padLeft(2, '0')}",
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
