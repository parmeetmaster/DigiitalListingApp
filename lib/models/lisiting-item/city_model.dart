// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

class CityModel {
  CityModel({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory CityModel.fromRawJson(String str) => CityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
