import 'package:buyer_app/src/widgets/chat_card.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/authservice.dart';
import '../services/firebase_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = AuthService().auth;
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
                MaterialPageRoute(builder: (context) => HomeScreen(currentCategory:'Popular',sort: 'Default')));
          },
        ),
        backgroundColor: Colors.cyan.shade900,
        centerTitle: true,
        title: Text('All Chats', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _service.messages
              .where('users', arrayContains: _auth.currentUser!.uid).orderBy('lastChatTime',descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return new ChatCard(data);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
