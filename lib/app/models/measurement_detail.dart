// To parse this JSON data, do
//
//     final measurementDetail = measurementDetailFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MeasurementDetail measurementDetailFromJson(dynamic data) =>
    MeasurementDetail.fromJson(data);

String measurementDetailToJson(MeasurementDetail data) =>
    json.encode(data.toJson());

class MeasurementDetail extends Equatable {
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
  final Penimbangan? penimbangan;

  const MeasurementDetail({
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
    this.penimbangan,
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
    penimbangan,
  ];

  factory MeasurementDetail.fromJson(Map<String, dynamic> json) =>
      MeasurementDetail(
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
        penimbangan: json["penimbangan"] == null
            ? null
            : Penimbangan.fromJson(json["penimbangan"]),
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
    "penimbangan": penimbangan?.toJson(),
  };
}

class Penimbangan extends Equatable {
  final int? id;
  final int? identitasId;
  final DateTime? tanggalUkur;
  final double? berat;
  final double? tinggi;
  final double? lila;
  final double? lingkarKepala;
  final String? caraUkur;
  final String? vitaminA;
  final int? pittingEdema;
  final int? kelasIbuBalita;
  final String? asiBulan0;
  final String? asiBulan1;
  final String? asiBulan2;
  final String? asiBulan3;
  final String? asiBulan4;
  final String? asiBulan5;
  final String? asiBulan6;
  final String? pemberianKe;
  final dynamic sumberPmt;
  final dynamic pemberianPusat;
  final dynamic tahunProduksi;
  final dynamic pemberianDaerah;
  final String? stunting;
  final String? beratBadan;
  final String? statusGizi;
  final int? mbg;

  const Penimbangan({
    this.id,
    this.identitasId,
    this.tanggalUkur,
    this.berat,
    this.tinggi,
    this.lila,
    this.lingkarKepala,
    this.caraUkur,
    this.vitaminA,
    this.pittingEdema,
    this.kelasIbuBalita,
    this.asiBulan0,
    this.asiBulan1,
    this.asiBulan2,
    this.asiBulan3,
    this.asiBulan4,
    this.asiBulan5,
    this.asiBulan6,
    this.pemberianKe,
    this.sumberPmt,
    this.pemberianPusat,
    this.tahunProduksi,
    this.pemberianDaerah,
    this.stunting,
    this.beratBadan,
    this.statusGizi,
    this.mbg,
  });

  @override
  List<Object?> get props => [
    id,
    identitasId,
    tanggalUkur,
    berat,
    tinggi,
    lila,
    lingkarKepala,
    caraUkur,
    vitaminA,
    pittingEdema,
    kelasIbuBalita,
    asiBulan0,
    asiBulan1,
    asiBulan2,
    asiBulan3,
    asiBulan4,
    asiBulan5,
    asiBulan6,
    pemberianKe,
    sumberPmt,
    pemberianPusat,
    tahunProduksi,
    pemberianDaerah,
    stunting,
    beratBadan,
    statusGizi,
    mbg,
  ];

  factory Penimbangan.fromJson(Map<String, dynamic> json) => Penimbangan(
    id: json["id"],
    identitasId: json["identitas_id"],
    tanggalUkur: json["tanggal_ukur"] == null
        ? null
        : .parse(json["tanggal_ukur"]),
    berat: json["berat"]?.toDouble(),
    tinggi: json["tinggi"]?.toDouble(),
    lila: json["lila"]?.toDouble(),
    lingkarKepala: json["lingkar_kepala"]?.toDouble(),
    caraUkur: json["cara_ukur"],
    vitaminA: json["vitamin_a"],
    pittingEdema: json["pitting_edema"],
    kelasIbuBalita: json["kelas_ibu_balita"],
    asiBulan0: json["asi_bulan_0"],
    asiBulan1: json["asi_bulan_1"],
    asiBulan2: json["asi_bulan_2"],
    asiBulan3: json["asi_bulan_3"],
    asiBulan4: json["asi_bulan_4"],
    asiBulan5: json["asi_bulan_5"],
    asiBulan6: json["asi_bulan_6"],
    pemberianKe: json["pemberian_ke"],
    sumberPmt: json["sumber_pmt"],
    pemberianPusat: json["pemberian_pusat"],
    tahunProduksi: json["tahun_produksi"],
    pemberianDaerah: json["pemberian_daerah"],
    stunting: json["stunting"],
    beratBadan: json["berat_badan"],
    statusGizi: json["status_gizi"],
    mbg: json["mbg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "identitas_id": identitasId,
    "tanggal_ukur": tanggalUkur == null
        ? null
        : "${tanggalUkur!.year.toString().padLeft(4, '0')}-${tanggalUkur!.month.toString().padLeft(2, '0')}-${tanggalUkur!.day.toString().padLeft(2, '0')}",
    "berat": berat,
    "tinggi": tinggi,
    "lila": lila,
    "lingkar_kepala": lingkarKepala,
    "cara_ukur": caraUkur,
    "vitamin_a": vitaminA,
    "pitting_edema": pittingEdema,
    "kelas_ibu_balita": kelasIbuBalita,
    "asi_bulan_0": asiBulan0,
    "asi_bulan_1": asiBulan1,
    "asi_bulan_2": asiBulan2,
    "asi_bulan_3": asiBulan3,
    "asi_bulan_4": asiBulan4,
    "asi_bulan_5": asiBulan5,
    "asi_bulan_6": asiBulan6,
    "pemberian_ke": pemberianKe,
    "sumber_pmt": sumberPmt,
    "pemberian_pusat": pemberianPusat,
    "tahun_produksi": tahunProduksi,
    "pemberian_daerah": pemberianDaerah,
    "stunting": stunting,
    "berat_badan": beratBadan,
    "status_gizi": statusGizi,
    "mbg": mbg,
  };
}
