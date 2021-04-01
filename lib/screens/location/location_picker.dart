import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_places/flutter_places.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/providers/location_provider.dart';
import 'package:listar_flutter_pro/utils/UUIDGenerator.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  static const classname = "/LocationScreen";

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    final provider = Provider.of<LocationProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
   final provider= Provider.of<LocationProvider>(context,listen: false);
  provider.context  =context;
    return Consumer<LocationProvider>(builder: (context, value, child) {
      return WillPopScope(
        onWillPop: (){
          if(provider.markers.isEmpty ){
           Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please add marker")));
          }else{
            Navigator.pop(context);
          }
        },
        child: Scaffold(

          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor:  Colors.transparent,
          actions: [
            SizedBox(width: 25,),
            InkWell(
              onTap: (){
                loadoverlay(context);
              },
              child: Container(
              height: 35,
              width: 35,
              child: Icon(Icons.search),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle
              ),),
            ),
            SizedBox(width: 25,),
          ],
          ),
          body: GoogleMap(
            mapToolbarEnabled: false,
            markers: value.markers,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              value.map_controller = controller;
            },
            onTap: value.addMarker,
          ),
          floatingActionButton: FloatingActionButton(
              child:Icon(Icons.check),
              onPressed: () {
                value.getLocationName();
                // todo add position for address;
              }),
        ),
      );
    });
  }

  loadoverlay(context) async {
    final provider = Provider.of<LocationProvider>(context, listen: false);

    Place place = await FlutterPlaces.show(
      context: context,
      apiKey: google_place_api_key,
      modeType: ModeType.OVERLAY,
      searchOptions: SearchOptions(sessionToken: UuidGenerator().getV4Uuid()),
    );
    provider.setMarkerUsingPlaceDetails(place);
  }

  void _handleTap(LatLng argument) {}
}
