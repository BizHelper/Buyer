import 'package:buyer_app/src/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthService {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
 /* CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  createChatRoom({chatData}) {
    // need change to  catch error
    messages.doc(chatData['chatRoomId']).set(chatData).catchError((e){
      print(e.toString());
    });
  }

  */
}



