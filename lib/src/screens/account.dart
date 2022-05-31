import 'package:buyer_app/src/products.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';

class AccountScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
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
          /*
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 11),
            child: Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.amber,
                  child: const Text(
                    "Popular",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "Bags & Wallets",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "Women clothing",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "Men clothing",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "Food & Beverage",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "Accessories",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "Toys & Games",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange,
                  child: const Text(
                    "  Others  ",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const Flexible(
            child: Products(),
          ),

           */
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
                        onTap: () { Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LocationScreen()));},
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
                        onTap: () {},
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
