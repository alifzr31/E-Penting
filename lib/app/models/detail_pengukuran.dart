// To parse this JSON data, do
//
//     final detailPengukuran = detailPengukuranFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

DetailPengukuran detailPengukuranFromJson(dynamic data) =>
    DetailPengukuran.fromJson(data);

String detailPengukuranToJson(DetailPengukuran data) =>
    json.encode(data.toJson());

class DetailPengukuran extends Equatable {
  final int? id;
  final String? nikAnak;
  final String? namaAnak;
  final DateTime? tanggalLahir;
  final Penimbangan? penimbangan;

  const DetailPengukuran({
    this.id,
    this.nikAnak,
    this.namaAnak,
    this.tanggalLahir,
    this.penimbangan,
  });

  @override
  List<Object?> get props => [id, nikAnak, namaAnak, tanggalLahir, penimbangan];

  factory DetailPengukuran.fromJson(Map<String, dynamic> json) =>
      DetailPengukuran(
        id: json["id"],
        nikAnak: json["nik_anak"],
        namaAnak: json["nama_anak"],
        tanggalLahir:
            json["tanggal_lahir"] == null
                ? null
                : DateTime.parse(json["tanggal_lahir"]),
        penimbangan:
            json["penimbangan"] == null
                ? null
                : Penimbangan.fromJson(json["penimbangan"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nik_anak": nikAnak,
    "nama_anak": namaAnak,
    "tanggal_lahir":
        "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
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
  ];

  factory Penimbangan.fromJson(Map<String, dynamic> json) => Penimbangan(
    id: json["id"],
    identitasId: json["identitas_id"],
    tanggalUkur:
        json["tanggal_ukur"] == null
            ? null
            : DateTime.parse(json["tanggal_ukur"]),
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "identitas_id": identitasId,
    "tanggal_ukur":
        "${tanggalUkur!.year.toString().padLeft(4, '0')}-${tanggalUkur!.month.toString().padLeft(2, '0')}-${tanggalUkur!.day.toString().padLeft(2, '0')}",
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
  };
}
