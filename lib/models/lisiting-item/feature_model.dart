// To parse this JSON data, do
//
//     final featureModel = featureModelFromJson(jsonString);

import 'dart:convert';

class FeatureModel {
  FeatureModel({
    this.success,
    this.data,
  });

  bool success;
  List<DataFeature> data;

  factory FeatureModel.fromRawJson(String str) => FeatureModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
    success: json["success"],
    data: List<DataFeature>.from(json["data"].map((x) => DataFeature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataFeature {
  DataFeature({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DataFeature.fromRawJson(String str) => DataFeature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataFeature.fromJson(Map<String, dynamic> json) => DataFeature(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
