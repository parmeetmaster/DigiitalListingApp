

// To parse this JSON data, do
//
//     final googlePlaceResponse = googlePlaceResponseFromJson(jsonString);

import 'dart:convert';

class GooglePlaceResponse {
  GooglePlaceResponse({
    this.plusCode,
    this.results,
    this.status,
  });

  PlusCode plusCode;
  List<Result> results;
  String status;

  factory GooglePlaceResponse.fromRawJson(String str) => GooglePlaceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GooglePlaceResponse.fromJson(Map<String, dynamic> json) => GooglePlaceResponse(

    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "plus_code": plusCode.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
  };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromRawJson(String str) => PlusCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}

class Result {
  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
    this.plusCode,
  });

  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  List<String> types;
  PlusCode plusCode;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
    formattedAddress: json["formatted_address"],
    geometry: Geometry.fromJson(json["geometry"]),
    placeId: json["place_id"],
    types: List<String>.from(json["types"].map((x) => x)),
    plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
  );

  Map<String, dynamic> toJson() => {
    "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
    "formatted_address": formattedAddress,
    "geometry": geometry.toJson(),
    "place_id": placeId,
    "types": List<dynamic>.from(types.map((x) => x)),
    "plus_code": plusCode == null ? null : plusCode.toJson(),
  };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory AddressComponent.fromRawJson(String str) => AddressComponent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
    longName: json["long_name"],
    shortName: json["short_name"],
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

class Geometry {
  Geometry({

    this.location,
    this.locationType,

  });


  Location location;
  String locationType;


  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(

    location: Location.fromJson(json["location"]),
    locationType: json["location_type"],
  );

  Map<String, dynamic> toJson() => {

    "location": location.toJson(),
    "location_type": locationType,

  };
}


class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
