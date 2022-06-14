import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:buyer_app/src/firebase_service.dart';

class ChatConversations extends StatefulWidget {
  final String chatRoomId;
  ChatConversations({required this.chatRoomId});

  @override
  State<ChatConversations> createState() => _ChatConversationsState();
}

class _ChatConversationsState extends State<ChatConversations> {
  FirebaseService _service = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var chatMessageController = TextEditingController();
  bool _send = false;

  sendMessage() {
    if (chatMessageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'message': chatMessageController.text,
        'sentBy': _auth.currentUser!.uid,
        'time': DateTime.now().microsecondsSinceEpoch,
      };
      _service.createChat(widget.chatRoomId, message);
      chatMessageController.clear();
    }
  }

  Stream<QuerySnapshot>? chatMessageStream;

  @override
  void initState() {
    _service.getChat(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade900,
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: chatMessageStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String sentBy = snapshot.data!.docs[index]['sentBy'];
                      String me = _auth.currentUser!.uid;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ChatBubble(
                              backGroundColor:
                              sentBy == me ? Colors.green : Colors.blue,
                              alignment: sentBy == me
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              clipper: ChatBubbleClipper2(
                                  type: sentBy == me
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble),
                              child:
                              Text(snapshot.data!.docs[index]['message']),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade800)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: chatMessageController,
                        style: TextStyle(color: Colors.blue),
                        decoration: const InputDecoration(
                            hintText: 'Type Message',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _send = true;
                            });
                          } else {
                            setState(() {
                              _send = false;
                            });
                          }
                        },
                        onSubmitted: (value) {
                          if (value.length > 0) {
                            sendMessage();
                          }
                        }),
                  ),
                  Visibility(
                    visible: _send,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}