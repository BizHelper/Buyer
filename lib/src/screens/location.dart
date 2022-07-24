import 'package:buyer_app/src/providers/LocationProvider.dart';
import 'package:buyer_app/src/screens/SellerDescriptionScreen.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../widgets/navigateBar.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sellers')
            .where('hasShop', isEqualTo: "true")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (!snapShot.hasData) return Container();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shops Near Me",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.orange[600])),
                              onPressed: () async {
                                await locationData.getCurrentPosition();
                                if (locationData.permissionALlowed == true) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen()));
                                } else {
                                  print('Permission not allowed');
                                }
                              },
                              child: Text('Set Your Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ))),
                        ],
                      )
                    ]),
              ),
              Flexible(
                child: ListView(
                    children: snapShot.data!.docs.map(
                  (DocumentSnapshot document) {
                    double dis = Geolocator.distanceBetween(
                        _userLatitude,
                        _userLongitude,
                        document['latitude'],
                        document['longitude']);
                    double dis1 = dis / 1000;
                    if (dis1 > 100) {
                      return Container();
                    }
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: SizedBox(
                            child: Image.network(document['Profile Pic']),
                            height: 50,
                            width: 50),
                        title: Text(document['Name'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                double.parse(dis1.toString())
                                        .toStringAsFixed(2) +
                                    ' km away',
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SellerDescriptionScreen(
                                    profilePicUrl: document['Profile Pic'],
                                    name: document['Name'],
                                    description: document['Description'],
                                    address: document['Address'])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 24.0,
                                  color: Colors.red[900],
                                ),
                                Text(
                                  'View Shop',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList()),
              ),
              NavigateBar()
            ],
          );
        },
      ),
    );
  }
}
