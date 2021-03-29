// To parse this JSON data, do
//
//     final listingResponse = listingResponseFromJson(jsonString);

import 'dart:convert';

class ListingResponse {
  ListingResponse({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory ListingResponse.fromRawJson(String str) => ListingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListingResponse.fromJson(Map<String, dynamic> json) => ListingResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
