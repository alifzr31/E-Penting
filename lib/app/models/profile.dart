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
  };
}
