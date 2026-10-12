// To parse this JSON data, do
//
//     final tallGrowth = tallGrowthFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

TallGrowth tallGrowthFromJson(dynamic data) => TallGrowth.fromJson(data);

String tallGrowthToJson(TallGrowth data) => json.encode(data.toJson());

class TallGrowth extends Equatable {
  final List<String>? labels;
  final List<double>? data;

  const new({this.labels, this.data});

  @override
  List<Object?> get props => [labels, data];

  factory TallGrowth.fromJson(Map<String, dynamic> json) => TallGrowth(
    labels: json["labels"] == null
        ? []
        : List<String>.from(json["labels"]!.map((x) => x)),
    data: json["data"] == null
        ? []
        : List<double>.from(json["data"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "labels": labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
