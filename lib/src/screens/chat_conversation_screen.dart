import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:buyer_app/src/services/firebase_service.dart';

class ChatConversations extends StatefulWidget {
  final String chatRoomId;
  final String type;
  ChatConversations({required this.chatRoomId, required this.type});
  @override
  State<ChatConversations> createState() => _ChatConversationsState();
}

class _ChatConversationsState extends State<ChatConversations> {
  FirebaseService _service = FirebaseService();
  final FirebaseAuth _auth = AuthService().auth;
  var chatMessageController = TextEditingController();
  bool _send = false;

  sendMessage() {
    if (chatMessageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'message': chatMessageController.text,
        'sentBy': _auth.currentUser!.uid,
        'time': DateTime.now().microsecondsSinceEpoch,
      };
      if (widget.type == 'listings') {
        _service.createChat(widget.chatRoomId, message);
      } else {
        _service.createRequestChat(widget.chatRoomId, message);
      }
      chatMessageController.clear();
    }
  }

  Stream<QuerySnapshot>? chatMessageStream;

  void initState() {
    if (widget.type == 'listings') {
      _service.getChat(widget.chatRoomId).then(
        (value) {
          setState(
            () {
              chatMessageStream = value;
            },
          );
        },
      );
      super.initState();
    } else {
      _service.getRequestChat(widget.chatRoomId).then((value) {
        setState(() {
          chatMessageStream = value;
        });
      });
      super.initState();
    }
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
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      int reverseIndex = snapshot.data!.docs.length - 1 - index;
                      String sentBy =
                          snapshot.data!.docs[reverseIndex]['sentBy'];
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
                              child: Text(
                                  snapshot.data!.docs[reverseIndex]['message']),
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
                      },
                    ),
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
