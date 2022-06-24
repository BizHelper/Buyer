import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/services/firebase_service.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:buyer_app/src/widgets/requestChatCard.dart';

class RequestChatScreen extends StatefulWidget {
  const RequestChatScreen({Key? key}) : super(key: key);

  @override
  State<RequestChatScreen> createState() => _RequestChatScreenState();
}

class _RequestChatScreenState extends State<RequestChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RequestScreen()));
          },
        ),
        backgroundColor: Colors.cyan.shade900,
        title: const Text('All Chats', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.requestMessages
            .where('users', arrayContains: _auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView(
            children:
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;
              return RequestChatCard(data);
            }).toList(),
          );
        },
      ),
    );
  }
}