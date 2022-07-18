import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/account.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/request.dart';

import '../screens/explore.dart';
import '../screens/location.dart';

class NavigateBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.black),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                key: Key("explorePage"),
                width: 55,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                key: Key("requestPage"),
                width: 55,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RequestScreen(type: 'Pending')));
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
                        MaterialPageRoute(builder: (context) => HomeScreen(currentCategory: 'Popular',sort: 'Default')));
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
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LocationScreen()));
                  },
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
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
    );
  }
}
