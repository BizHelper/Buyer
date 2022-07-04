import 'dart:collection';

import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import '../providers/LocationProvider.dart';
import 'package:geocoder2/geocoder2.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String id = 'map-screen';
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng currentLocation;
  String googleApikey = "AIzaSyDOJ2t5HwT4OHU10hT4Ing9OFtQGtwy150";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";
  @override
  Widget build(BuildContext context) {


   final locationData = Provider.of<LocationProvider>(context);
   /*method() async {
     GeoData data = await Geocoder2.getDataFromCoordinates(
         latitude: locationData.latitude,
         longitude: locationData.longitude,
         googleMapApiKey: "AIzaSyDOJ2t5HwT4OHU10hT4Ing9OFtQGtwy150");
     locationData.selectedAddress =data.address;
   }

    */
    setState(()  {
     // method();
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
        mapController = controller;
      });
    }

    FirebaseFirestore.instance
        .collection('buyers')
        .get()
        .then((value) => value.docs.forEach((element) {
      var docRef = FirebaseFirestore.instance
          .collection('buyers')
          .doc(AuthService().currentUser!.uid);
      docRef.update({'longitude': locationData.longitude});
      docRef.update({'latitude': locationData.latitude});
    }));

    return Scaffold(
      appBar: AppBar(
          title: Text('Your Location'),
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LocationScreen()))),
          backgroundColor: Colors.teal),
      body:

      SafeArea(
        child: Stack(
          children: [
           // Column(
             //children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 14.476,
                  ),
                  zoomControlsEnabled: false,
                  minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  mapToolbarEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    locationData.onCameraMove(position);
                  },
                  onMapCreated: onCreated,
                  onCameraIdle: () {
                  //  method();
                 //   method();
                    locationData.getMoveCamera();
                  },
                ),
                Center(
                  child: Container(height: 35,
                  margin: EdgeInsets.only(bottom: 40),
                  child: Image.asset('images/image l.png'))
                ),


         //     ],
           // ),
            // later can add the profile image marker....
         /*   Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(locationData.selectedAddress),
                    )
                  //  Text(LocationProvider().selectedAddress)
                    //Text(locationData.selectedAddress)
                  // Text(locationData.selectedAddress.featureName),
                    // Text(locationData.selectedAddress.addressLine),
                  ],
                ),
              ),
            ),
            */
            Positioned(  //search input bar
                top:10,
                child: InkWell(
                    onTap: () async {
                     // method();
                      var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'sg')],
                          //google_map_webservice package
                          onError: (err){
                            print(err);
                          }
                      );
                      if(place != null){
                        setState(() {
                          location = place.description.toString();
                        });
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(apiKey:googleApikey,
                          apiHeaders: await GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);
                        //move map camera to selected place with animation
                        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                      }
                    },
                    child:Padding(
                      padding: EdgeInsets.all(15),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListTile(
                              title:Text(location, style: TextStyle(fontSize: 18),),
                              trailing: Icon(Icons.search),
                              dense: true,
                            )
                        ),
                      ),
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}