// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);

import 'dart:convert';

class CategoryData {
  CategoryData({
    this.success,
    this.data,
  });

  bool success;
  List<CategoryDataItem> data;

  factory CategoryData.fromRawJson(String str) => CategoryData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    success: json["success"],
    data: List<CategoryDataItem>.from(json["data"].map((x) => CategoryDataItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryDataItem {
  CategoryDataItem({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CategoryDataItem.fromRawJson(String str) => CategoryDataItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryDataItem.fromJson(Map<String, dynamic> json) => CategoryDataItem(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
