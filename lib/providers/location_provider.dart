import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_places/flutter_places.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter_pro/models/google_place_response.dart';
import 'package:provider/provider.dart';

import 'lisitItemProvider.dart';

class LocationProvider extends ChangeNotifier {
  // Completer<GoogleMapController> map_controller = Completer();
  GoogleMapController map_controller;
  Set<Marker> markers;

  BuildContext context;

  void addMarker(LatLng argument) {
    markers = {};

    markers.add(Marker(
      markerId: MarkerId(argument.toString()),
      position: argument,
      infoWindow: InfoWindow(
        title: 'Location Selected',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
    notifyListeners();
  }

  Future<void> setMarkerUsingPlaceDetails(Place place) async {
    // Move camera to location
    final curruntCameraPosition = await CameraPosition(
      target: LatLng(place.placeDetails.geometry.location.lat,
          place.placeDetails.geometry.location.lng),
      zoom: 14.4746,
    );
    CameraUpdate cameraUpdate =
        CameraUpdate.newCameraPosition(curruntCameraPosition);
    map_controller.moveCamera(cameraUpdate);
    notifyListeners();
  }

  void getLocationName() async {
    final listing_provider=Provider.of<ListItemProvider>(context,listen: false);
    Dio dio = new Dio();
    if (markers == null || markers.isEmpty) return;

    Response resp = await dio.post(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${markers.first.position.latitude},${markers.first.position.longitude}&key=AIzaSyAUnyaLnML1e0eoBOyarg2OfVTIwMB0apw");
    GooglePlaceResponse gobj = GooglePlaceResponse.fromJson(resp.data);
    listing_provider.addressController.text=gobj.results[0].formattedAddress;
    Navigator.pop(context);
  }
}
