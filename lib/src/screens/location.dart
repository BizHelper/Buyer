import 'package:buyer_app/src/providers/LocationProvider.dart';
import 'package:buyer_app/src/screens/SellerDescriptionScreen.dart';
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

import 'mapscreen.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _auth = AuthService().auth;
  double _userLatitude = 0.0;
  double _userLongitude = 0.0;
  var distanceInKm;

  void getDistanceHelper() async {
    String _uid = _auth.currentUser!.uid;
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('buyers').doc(_uid).get();
    // change to buyers
    setState(() => _userLatitude = ds.get('latitude'));
    setState(() => _userLongitude = ds.get('longitude'));
  }

  void initState() {
    build(context);
    getDistanceHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
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
          stream: FirebaseFirestore.instance.collection('sellers').
          where('hasShop', isEqualTo: "true").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
            if (!snapShot.hasData) return
            Container();
            return Column(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          child: Text('Set Your Location',style: TextStyle(fontSize: 16)),
                          onPressed: () async {
                            await locationData.getCurrentPosition();
                            // print(locationData.permissionALlowed);
                            if (locationData.permissionALlowed == true) {
                              //   Navigator.pushReplacementNamed(
                              //      context, MapScreen.id);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen()));
                            } else {
                              print('Permission not allowed');
                            }
                          }),
                    ]),
                Flexible(
                  child: Container(
                    child: ListView(
                        children: snapShot.data!.docs.map(
                      (DocumentSnapshot document) {
                        //   String dis =  getDistance1(document['Seller ID']);
                        // print(dis);
                        // add the document check if got shop here as a field... under sellers.
                        double dis = Geolocator.distanceBetween(
                            _userLatitude,
                            _userLongitude,
                            document['Latitude'],
                            document['Longitude']);
                        double dis1 = dis / 1000;
                        if (dis1 > 100) {
                          return Container();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: InkWell(
                              onTap: (){ Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (context) =>  SellerDescriptionScreen(
                          profilePicUrl:document['Profile Pic'], name: document['Name'])));},
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                     // shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: Image.network(document['Profile Pic']).image,
                                      ),
                                    ),
                                  ),
                                // SizedBox(child: Image.network(document['Profile Pic']),
                                 //width: 200,height: 200,),
                                  Container(child: Text(document['Name'])),
                                  Text(double.parse(dis1.toString()).toStringAsFixed(2) + ' km')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList()),
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
                                        builder: (context) => ExploreScreen()));
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
                                            currentCategory: 'Popular',sort: 'Default')));
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
                                        builder: (context) => AccountScreen()));
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
              ],
            );
          },
        ),
      ),
    );
  }
}
