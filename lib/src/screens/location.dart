import 'package:buyer_app/src/screens/account.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';

class LocationScreen extends StatelessWidget {
  final _auth = AuthService().auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
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
          'Home',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                              MaterialPageRoute(builder: (context) => ExploreScreen()));
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
                        onTap: () { Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => RequestScreen()));},
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
                        onTap: () {Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomeScreen()));},
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
                        onTap: () { Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => AccountScreen()));},
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
          ),
        ],
      ),
    );
  }
}
