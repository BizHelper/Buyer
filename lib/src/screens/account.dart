import 'package:buyer_app/src/authservice.dart';
import 'package:buyer_app/src/products.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:provider/provider.dart';


class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('hi'));
  }
}
