// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

import 'dart:convert';

class CommonListingModel {
  CommonListingModel({
    this.success,
    this.data,
  });

  bool success;
  List<DataItems> data;

  factory CommonListingModel.fromRawJson(String str) => CommonListingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommonListingModel.fromJson(Map<String, dynamic> json) => CommonListingModel(
    success: json["success"],
    data: List<DataItems>.from(json["data"].map((x) => DataItems.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataItems {
  DataItems({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DataItems.fromRawJson(String str) => DataItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataItems.fromJson(Map<String, dynamic> json) => DataItems(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
