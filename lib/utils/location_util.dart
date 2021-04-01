import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

Position position;
enum location_status{noerror,permanent_denied,currunt_denied}

class LocationStatus{

  String message;
  dynamic errcode;


  LocationStatus({this.message,this.errcode});
}



Future<LocationStatus> detectCurruntLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return LocationStatus(errcode: location_status.permanent_denied,message: "Location permissions is permanently Denied");

  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return LocationStatus(errcode: location_status.currunt_denied,message: "Location permission denied ");
    }
  }

  position= await Geolocator.getCurrentPosition();
  if(position!=null){
    return LocationStatus(errcode: location_status.noerror,message: "Location found");
  }

}