import 'dart:collection';

import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/LocationProvider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String id = 'map-screen';
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {


    final locationData = Provider.of<LocationProvider>(context);
    FirebaseFirestore.instance.collection('buyers').get().then((value)=>
    value.docs.forEach((element) {
      var docRef = FirebaseFirestore.instance.collection('buyers').doc(AuthService().currentUser!.uid);
      docRef.update({'longitude': locationData.longitude});
      docRef.update({'latitude': locationData.latitude});
    }));

    return
    Scaffold(
        appBar: AppBar(
            title: Text('Your Location'),
            leading: BackButton(color: Colors.white, onPressed:()=>
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LocationScreen()))),
            backgroundColor: Colors.teal),
       body: Center(
         // child: Text('hi')

        child:Text('${locationData.latitude}:${locationData.longitude}'),
        ),
    );

  }
}
