import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;
  bool permissionALlowed = false;

  Future<void> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      permissionALlowed = true;
      notifyListeners();
    } else {
      print('Permission not allowed');
    }
  }

  void onCameraMove(CameraPosition cameraPosition) async {
    this.latitude = cameraPosition.target.latitude;
    this.longitude = cameraPosition.target.longitude;
   /*GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: this.latitude,
        longitude: this.longitude,
        googleMapApiKey: "AIzaSyDOJ2t5HwT4OHU10hT4Ing9OFtQGtwy150");
    this.selectedAddress =data.address;
    */
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
     GeoData data = await Geocoder2.getDataFromCoordinates(
         latitude: this.latitude,
         longitude: this.longitude,
         googleMapApiKey: "AIzaSyDOJ2t5HwT4OHU10hT4Ing9OFtQGtwy150");
  }


}
