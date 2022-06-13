/*import 'package:buyer_app/src/chat_stream.dart';
import 'package:buyer_app/src/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatConversations extends StatefulWidget {
  final String chatRoomId;
  ChatConversations({required this.chatRoomId});

  //const ChatConversations({Key? key}) : super(key: key);

  @override
  State<ChatConversations> createState() => _ChatConversationsState();
}


class _ChatConversationsState extends State<ChatConversations> {
  FirebaseService _service = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var chatMessageController = TextEditingController();
  bool _send = false;
  sendMessage() {
    if(chatMessageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'message': chatMessageController.text,
        'sentBy':  _auth.currentUser!.uid,
        'time': DateTime.now().microsecondsSinceEpoch,
      };
      _service.createChat(widget.chatRoomId, message);
      chatMessageController.clear();
    }
  }


  Stream<QuerySnapshot> chatMessageStream =  FirebaseFirestore.instance.collection('messages').snapshots();
  /*@override
  void initState() {
    _service.getChat(widget.chatRoomId).then((value){
      setState((){
        chatMessageStream = value;

      });
    });
    super.initState();
  }



   */

  late DocumentSnapshot chatDoc;
  void initState()  {
    //  chatDoc = await FirebaseFirestore.instance.collection('sellers').doc('fwef').get();
    _service.getChat(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    _service.messages.doc(widget.chatRoomId).get().then((value) {
      setState(() {
        chatDoc = value;
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    /*class _ChatConversationsState extends State<ChatConversations> {
    FirebaseService _service = FirebaseService();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var chatMessageController = TextEditingController();
    bool _send = false;
    sendMessage() {
    if(chatMessageController.text.isNotEmpty) {
    Map<String, dynamic> message = {
    'message': chatMessageController.text,
    'sentBy':  _auth.currentUser!.uid,
    'time': DateTime.now().microsecondsSinceEpoch,
    };
    _service.createChat(widget.chatRoomId, message);
    chatMessageController.clear();
    }
    }

     */
    // go see video at 23.54
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: [
         Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder (
               //   stream: FirebaseFirestore.instance.collection('messages').snapshots(),
                stream: chatMessageStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData?
                       ListView.builder(itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,  index) {
                        //  return Text(snapshot.data!.docs[index]['messages'],);});

                    //  print(Text(snapshot.data!.docs[index]['messages'],));
                      return Text(snapshot.data!.docs[index]['message'],);}): Container();
                      //return Text('messages',);}
                        //);



                    Column(
                      children: [
                       /* ListTile(
                         //   title: Text(chatDoc['Name']['Price']),
                            trailing: Row(
                              children: [
                           //     Text(chatDoc['Name']['Price']),
                                SizedBox(width: 100),

                              ],
                            )
                        ),

                        */
                        ListView.builder(itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              //  return Text(snapshot.data!.docs[index]['messages'],);});

                              //  print(Text(snapshot.data!.docs[index]['messages'],));
                              return Text(snapshot.data!.docs[index]['message'],);
                            }),
                      //],
                    //): Container();


            //Text('test');
           // Text('lastChat');
                        //),
                    //return Text(snapshot.data!.docs[index]['lastChat'],);});
                    //Container();




                    /*new ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document)){
                      Map<String, dynamic> data =
                  document.data() as Map<String,dynamic>;
                      return new ListTile(
                  title: new Text(data[])

                     */




          //  ChatStream(chatRoomId: widget.chatRoomId),

            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade800)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Expanded(child: TextField(
                        controller: chatMessageController,
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: 'Type Message',
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none
                        ),
                        onChanged: (value) {
                          if(value.isNotEmpty) {
                            setState((){
                              _send = true;
                            });
                          } else {
                            setState((){
                              _send = false;
                            });
                          }
                        },
                        onSubmitted: (value){
                          if(value.length>0){
                            sendMessage();
                          }
                        },
                      )),
                      Visibility(
                        visible: _send,
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: sendMessage,
                        ),
                      ),
                    ],
                  ),
                )
              )
            )
    ]), ), );

                }}*/

import 'package:buyer_app/src/chat_stream.dart';
import 'package:buyer_app/src/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

class ChatConversations extends StatefulWidget {
  final String chatRoomId;
  ChatConversations({required this.chatRoomId});

  //const ChatConversations({Key? key}) : super(key: key);

  @override
  State<ChatConversations> createState() => _ChatConversationsState();
}


class _ChatConversationsState extends State<ChatConversations> {
  FirebaseService _service = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var chatMessageController = TextEditingController();
  bool _send = false;
  sendMessage() {
    if(chatMessageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'message': chatMessageController.text,
        'sentBy':  _auth.currentUser!.uid,
        'time': DateTime.now().microsecondsSinceEpoch,
      };
      _service.createChat(widget.chatRoomId, message);
      chatMessageController.clear();
    }
  }
  Stream<QuerySnapshot> chatMessageStream =  FirebaseFirestore.instance.collection('messages').snapshots();
  @override
  void initState() {
    _service.getChat(widget.chatRoomId).then((value){
      setState((){
        chatMessageStream = value;

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /*class _ChatConversationsState extends State<ChatConversations> {
    FirebaseService _service = FirebaseService();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var chatMessageController = TextEditingController();
    bool _send = false;
    sendMessage() {
    if(chatMessageController.text.isNotEmpty) {
    Map<String, dynamic> message = {
    'message': chatMessageController.text,
    'sentBy':  _auth.currentUser!.uid,
    'time': DateTime.now().microsecondsSinceEpoch,
    };
    _service.createChat(widget.chatRoomId, message);
    chatMessageController.clear();
    }
    }

     */
    // go see video at 23.54
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
            children: [
                 Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder (
               //   stream: FirebaseFirestore.instance.collection('messages').snapshots(),
                stream: chatMessageStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData?
                        ListView.builder(itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,  index) {
                          //not sure for sent bY check again.
                          String sentBy = snapshot.data!.docs[index]['sentBy'];
                          String lastChatDate;
                          String me = _auth.currentUser!.uid;
                          // need do the date later
                   /*       var _date = DateTimeFormat.format(DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time']));
                  var _today = DateTimeFormat.format(DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch));
                      //  return Text(snapshot.data!.docs[index]['messages'],);});
                          if(_date == _today) {
                           lastChatDate =  DateTimeFormat.format(DateTime.fromMicrosecondsSinceEpoch(snapshot.data!.docs[index]['time']));
                          } else {
                            lastChatDate = _date.toString();
                          }

                    */
                      //  print(Text(snapshot.data!.docs[index]['messages'],));
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ChatBubble(

                              child: Text(snapshot.data!.docs[index]['message']),
                              backGroundColor: sentBy==me? Colors.green: Colors.blue,
                          alignment: sentBy == me? Alignment.centerRight: Alignment.centerLeft,
                          clipper: ChatBubbleClipper2(
                                  type: BubbleType.sendBubble),),
                  //    Text(lastChatDate),
                      ],
                        ),

                      );
                    })
                      //  Text(snapshot.data!.docs[index]['message'],);})
                        : Container();
                      //return Text('messages',);}
                        //);


            //Text('test');
           // Text('lastChat');
                        //),
                    //return Text(snapshot.data!.docs[index]['lastChat'],);});
                    //Container();
                    }, ),
            ),

                    /*new ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document)){
                      Map<String, dynamic> data =
                  document.data() as Map<String,dynamic>;
                      return new ListTile(
                  title: new Text(data[])

                     */




             // ChatStream(chatRoomId: widget.chatRoomId),

              Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey.shade800)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [

                            Expanded(child: TextField(
                              controller: chatMessageController,
                              style: TextStyle(color: Colors.blue),
                              decoration: InputDecoration(
                                  hintText: 'Type Message',
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none
                              ),
                              onChanged: (value) {
                                if(value.isNotEmpty) {
                                  setState((){
                                    _send = true;
                                  });
                                } else {
                                  setState((){
                                    _send = false;
                                  });
                                }

                              },
                                onSubmitted: (value){
                                  if(value.length>0){
                                    sendMessage();
                                  }
                                }
                            )),
                            Visibility(
                              visible: _send,
                              child: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: sendMessage,
                              ),
                            ),
                          ],
                        ),
                      )
                  )
              )
            ]), ), );

  }}

