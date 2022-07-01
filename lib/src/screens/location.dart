import 'package:buyer_app/src/providers/LocationProvider.dart';
import 'package:buyer_app/src/screens/account.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:buyer_app/src/providers/LocationProvider.dart';

import 'mapscreen.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _auth = AuthService().auth;

  //late double latitude;
   double _userLatitude = 0.0;

   double _userLongitude= 0.0;

  double _sellerLatitude = 0.0;

   double _sellerLongitude = 0.0;
  var distanceInKm;

  void getDistanceHelper() async {
    String _uid = _auth.currentUser!.uid;
    DocumentSnapshot ds = await FirebaseFirestore
        .instance
        .collection('buyers')
        .doc(_uid)
        .get();
    // change to buyers
    setState(()=>  _userLatitude = ds.get('latitude'));
    // print('hi');
    setState(()=>  _userLongitude = ds.get('longitude'));

  }
void initState(){
  build(context);
getDistanceHelper();

super.initState();


}
  @override
  Widget build(BuildContext context) {




  /* void getDistanceHelper2(String sellerID) async {
      DocumentSnapshot ds1= await FirebaseFirestore
          .instance
          .collection('sellers')
          .doc(sellerID)
          .get(); // change to buyers
     _sellerLatitude = ds1.get('Latitude');
     // print(_sellerLongitude-1);
     // print('hi');
     _sellerLongitude = ds1.get('Longitude');
    }


   */





 /*    getDistance(String sellerID) async {
     // getDistanceHelper();
     // getDistanceHelper2(sellerID);
      print(sellerID);
      DocumentSnapshot ds1= await FirebaseFirestore
          .instance
          .collection('sellers')
          .doc(sellerID)
          .get(); // change to buyers
      _sellerLatitude = await ds1.get('Latitude');
      // print(_sellerLongitude-1);
      // print('hi');
      _sellerLongitude = await ds1.get('Longitude');
       distanceInKm = await Geolocator.distanceBetween(_userLatitude, _userLongitude,
       _sellerLatitude, _sellerLongitude)/1000;

       // setState(()=> distanceInKm = distance/1000);
       // return distanceInKm;
      //return distanceInKm.toString();
      // check if they alr upload their location... cannot search before setting their location...
    }

    String getDistance1(String sellerID){
      getDistance(sellerID);
      return distanceInKm.toString();
    }


  */
    final locationData = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.cyan.shade900,
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
          title: const Text(
            'Location',
            style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('sellers').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapShot) {
                if (!snapShot.hasData) return CircularProgressIndicator();
                return Column(children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FlatButton(
                            child: Text('Set my location'),
                            onPressed: () async {
                              await locationData.getCurrentPosition();
                              // print(locationData.permissionALlowed);
                              if (locationData.permissionALlowed == true) {
                                Navigator.pushReplacementNamed(
                                    context, MapScreen.id);
                              } else {
                                print('Permission not allowed');
                              }
                            }),
                      ]),
                  Flexible(
                    child: Container(
                      child: ListView(
                     //   crossAxisCount: 2,
                        // scrollDirection: Axis.vertical,
                        children: snapShot.data!.docs.map(
                          (DocumentSnapshot document) {
                        //   String dis =  getDistance1(document['Seller ID']);
                          // print(dis);
                            double dis =  Geolocator.distanceBetween(_userLatitude, _userLongitude,
                                document['Latitude'], document['Longitude']);
                         if (dis<10) {
                           return Container();
                         }
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // width: 80,
                                child: Column(
                                    children: [
                                Container
                                (child: Text(document['Name'])),
                                    Text(
                                    dis.toString())

                                          // '${getDistance('wYrPfGpXuIRAjC3lgI6wRxv4jNX2')}Km')
                                  //'${getDistance(document['Seller ID'])}Km')
                                  ],
                                ),
                              ),
                          );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Divider(height: 1, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 55,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ExploreScreen()));
                                },
                                child: Column(
                                  children: const [
                                    Icon(Icons.explore),
                                    Text('Explore'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 55,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RequestScreen(type: 'Pending')));
                                },
                                child: Column(
                                  children: const [
                                    const Icon(Icons.sticky_note_2),
                                    Text('Request'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 55,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                              currentCategory: 'Popular')));
                                },
                                child: Column(
                                  children: const [
                                    Icon(Icons.home),
                                    Text('Home'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 55,
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: const [
                                    Icon(Icons.location_on),
                                    Text('location'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 55,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccountScreen()));
                                },
                                child: Column(
                                  children: const [
                                    Icon(Icons.account_box),
                                    Text('Account'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]);
              }),
        ));
  }
}
