import 'package:buyer_app/src/chat_card.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';

import '../firebase_service.dart';
/*
class ChatScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              elevation: 0.0,
              backgroundColor: Colors.cyan.shade900,
              title: Text('Chats', style: TextStyle(color: Colors.white)),
              bottom: TabBar(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  indicatorWeight: 6,
                  tabs: [
                    Tab(text: 'All Chats'),
                  ])),
          body: TabBarView(children: [
            Container(
              // need to include all the something went wrong stuff 38.59
              child: StreamBuilder<QuerySnapshot>(
                stream: _service.messages
                    .where('users', arrayContains: _auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return new ListView(
                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        return new ChatCard(data);
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ])),
    );
  }
}

 */




class ChatScreen extends StatefulWidget {
//  const ChatScreen({Key? key}) : super(key: key);
  //final String chatRoomId;
  //ChatScreen({required this.chatRoomId});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseService _service = FirebaseService();
    //Stream<QuerySnapshot> chatMessageStream =  FirebaseFirestore.instance.collection('messages').snapshots();
    //@override
    //void initState() {
    //  _service.getChat(widget.chatRoomId).then((value){
      //  setState((){
        //  chatMessageStream = value;
        //});
      //});
      //super.initState();
   // }

    @override
    Widget build(BuildContext context) {
      return
      /* DefaultTabController(
        length: 1,
        initialIndex: 0,
        child:

       */
        Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                backgroundColor: Colors.cyan.shade900,
                centerTitle: true,
                title: Text('All Chats', style: TextStyle(color: Colors.white)),
               /* bottom: TabBar(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorWeight: 6,
                    //tabs: [
                      //Tab(text: 'All Chats'),
                    //]
      )

                */
            ),
            body: Container(
              // need to include all the something went wrong stuff 38.59
              child: StreamBuilder<QuerySnapshot>(
                stream: _service.messages
                    .where('users', arrayContains: _auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return new ListView(
                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        return new ChatCard(data);
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ));

    }
  }
