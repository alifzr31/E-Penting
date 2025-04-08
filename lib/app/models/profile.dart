// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Profile profileFromStringJson(String str) => Profile.fromJson(json.decode(str));

Profile profileFromJson(dynamic data) => Profile.fromJson(data);

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? level;
  final int? kecamatan;
  final int? kelurahan;
  final int? puskesmas;
  final int? posyandu;
  final dynamic sekolah;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? namaKecamatan;
  final String? kodeKemendagriKecamatan;
  final String? namaKelurahan;
  final String? kodeKemendagriKelurahan;
  final String? namaPuskesmas;
  final String? namaPosyandu;
  final dynamic asikHealthCentreId;
  final List<Anak>? listAnak;

  const Profile({
    this.id,
    this.name,
    this.username,
    this.email,
    this.level,
    this.kecamatan,
    this.kelurahan,
    this.puskesmas,
    this.posyandu,
    this.sekolah,
    this.createdAt,
    this.updatedAt,
    this.namaKecamatan,
    this.kodeKemendagriKecamatan,
    this.namaKelurahan,
    this.kodeKemendagriKelurahan,
    this.namaPuskesmas,
    this.namaPosyandu,
    this.asikHealthCentreId,
    this.listAnak,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    level,
    kecamatan,
    kelurahan,
    puskesmas,
    posyandu,
    sekolah,
    createdAt,
    updatedAt,
    namaKecamatan,
    kodeKemendagriKecamatan,
    namaKelurahan,
    kodeKemendagriKelurahan,
    namaPuskesmas,
    namaPosyandu,
    asikHealthCentreId,
    listAnak,
  ];

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    level: json["level"],
    kecamatan: json["kecamatan"],
    kelurahan: json["kelurahan"],
    puskesmas: json["puskesmas"],
    posyandu: json["posyandu"],
    sekolah: json["sekolah"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    namaKecamatan: json["nama_kecamatan"],
    kodeKemendagriKecamatan: json["kode_kemendagri_kecamatan"],
    namaKelurahan: json["nama_kelurahan"],
    kodeKemendagriKelurahan: json["kode_kemendagri_kelurahan"],
    namaPuskesmas: json["nama_puskesmas"],
    namaPosyandu: json["nama_posyandu"],
    asikHealthCentreId: json["asik_health_centre_id"],
    listAnak:
        json["list_anak"] == null
            ? []
            : List<Anak>.from(json["list_anak"]!.map((x) => Anak.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "level": level,
    "kecamatan": kecamatan,
    "kelurahan": kelurahan,
    "puskesmas": puskesmas,
    "posyandu": posyandu,
    "sekolah": sekolah,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "nama_kecamatan": namaKecamatan,
    "kode_kemendagri_kecamatan": kodeKemendagriKecamatan,
    "nama_kelurahan": namaKelurahan,
    "kode_kemendagri_kelurahan": kodeKemendagriKelurahan,
    "nama_puskesmas": namaPuskesmas,
    "nama_posyandu": namaPosyandu,
    "asik_health_centre_id": asikHealthCentreId,
    "list_anak":
        listAnak == null
            ? []
            : List<dynamic>.from(listAnak!.map((x) => x.toJson())),
  };
}

class Anak extends Equatable {
  final String? nik;
  final String? nama;
  final DateTime? tanggalLahir;
  final String? jenisKelamin;

  const Anak({this.nik, this.nama, this.tanggalLahir, this.jenisKelamin});

  @override
  List<Object?> get props => [nik, nama, tanggalLahir, jenisKelamin];

  factory Anak.fromJson(Map<String, dynamic> json) => Anak(
    nik: json["nik"],
    nama: json["nama"],
    tanggalLahir:
        json["tanggal_lahir"] == null
            ? null
            : DateTime.parse(json["tanggal_lahir"]),
    jenisKelamin: json["jenis_kelamin"],
  );

  Map<String, dynamic> toJson() => {
    "nik": nik,
    "nama": nama,
    "tanggal_lahir":
        "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
    "jenis_kelamin": jenisKelamin,
  };
}
