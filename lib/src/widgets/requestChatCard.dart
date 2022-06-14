import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/firebase_service.dart';
import 'package:buyer_app/src/screens/chat_conversation_screen.dart';
import 'package:buyer_app/src/screens/requestDescription.dart';

class RequestChatCard extends StatefulWidget {
  final Map<String, dynamic> chatData;
  RequestChatCard(this.chatData);

  @override
  State<RequestChatCard> createState() => _RequestChatCardState();
}

class _RequestChatCardState extends State<RequestChatCard> {
  FirebaseService _service = FirebaseService();
  DocumentSnapshot? doc;
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  getRequestDetails() {
    _service.getRequestDetails(widget.chatData['request']['requestID']).then((value){
      setState((){
        doc = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    getRequestDetails();
    return doc == null?
    Container(): Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey), )
      ),
      child: ListTile(
        onTap: (){
          Navigator.push (
            context,
            MaterialPageRoute (
              builder: (BuildContext context) =>  ChatConversations(chatRoomId: widget.chatData['chatRoomId'], type: 'requests'),
            ),
          );
        },
        leading: Text('leading'),
        title: Text('title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('subtitle'),
          ],
        ),
        trailing: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDescriptionScreen(
              buyerID: widget.chatData['request']['buyerID'],
              buyerName: widget.chatData['request']['buyerName'],
              category: widget.chatData['request']['category'],
              deadline: widget.chatData['request']['deadline'],
              description: widget.chatData['request']['description'],
              price: widget.chatData['request']['price'],
              requestID: widget.chatData['request']['requestID'],
              sellerName: widget.chatData['request']['sellerName'],
              title: widget.chatData['request']['title'],
            )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  Icons.visibility,
                  size: 22.0,
                  color: Colors.red[900],
                ),
                Text(
                  'View Request',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.red[900],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}