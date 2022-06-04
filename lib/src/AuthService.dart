import 'package:buyer_app/src/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthService {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

}



