import 'dart:collection';

import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/LocationProvider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String id = 'map-screen';
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng currentLocation;
  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });
    void onCreated(GoogleMapController controller) {
      setState(() {
        _mapController = controller;
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
          //  Center(
          // child:Text('${locationData.latitude}:${locationData.longitude}'),
/*GoogleMap(initialCameraPosition: CameraPosition(
  target: LatLng(193, 122), zoom: 14.476,
),

 */
          SafeArea(
        child: Stack(
          children: [
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
                locationData.getMoveCamera();
              },
            ),
            // later can add the profile image marker....
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(locationData.selectedAddress.featureName),
                    Text(locationData.selectedAddress.addressLine),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
