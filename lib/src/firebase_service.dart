import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference messages = FirebaseFirestore.instance.collection(
      'messages');

  createChatRoom({chatData}) {
    // need change to  catch error
    messages.doc(chatData['chatRoomId']).set(chatData).catchError((e) {
      print(e.toString());
    });
  }

  createChat(String chatRoomId, message) {
    messages.doc(chatRoomId).collection('chats').add(message).catchError((e) {
      print(e.toString());
    });
    messages.doc(chatRoomId).update({
      'lastChat': message['message'],
      'lastChatTime' : message['time'],

    });
//    messages.doc(chatRoomId).collection('chats').add(message).catchError((e) {
  //    print(e.toString());
  //  });
  }
  getChat(chatRoomId) async{
   return messages.doc(chatRoomId).collection('chats').orderBy('time').snapshots();
  }
}