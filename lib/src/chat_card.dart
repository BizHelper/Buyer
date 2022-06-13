import 'package:buyer_app/src/firebase_service.dart';
import 'package:buyer_app/src/screens/chat_conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
final Map<String, dynamic> chatData;
ChatCard(this.chatData);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  FirebaseService _service = FirebaseService();
  late DocumentSnapshot doc;
  @override
  void initState() {
    getProductDetails();
    super.initState();
  }
  getProductDetails() {
    _service.getProductDetails(widget.chatData['product']['productDetailId']).then((value){
      setState((){
        doc = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return doc == null?
        Container(): Container(
      child: ListTile(
        onTap: (){
          Navigator.push (
            context,
            MaterialPageRoute (
              builder: (BuildContext context) =>  ChatConversations(chatRoomId: widget.chatData['chatRoomId']),
            ),
          );
        },
        leading: Image.network(doc['Image URL']),
        title: Text(doc['Name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doc['Description'], maxLines: 1),
            if(widget.chatData['lastChat']!= null)
              Text(widget.chatData['lastChat'], maxLines: 1, style: TextStyle(fontSize: 10))

          ],

        ),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey), )
      ),
    );
  }
}
