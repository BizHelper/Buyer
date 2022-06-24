import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  CollectionReference listings = FirebaseFirestore.instance.collection('listings');

  CollectionReference requestMessages = FirebaseFirestore.instance.collection('requestMessages');
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  createChatRoom({chatData}) {
    messages.doc(chatData['chatRoomId']).set(chatData).catchError((e) {
      print(e.toString());
    });
  }

  createRequestChatRoom({chatData}) {
    requestMessages.doc(chatData['chatRoomId']).set(chatData).catchError((e) {
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
  }

  createRequestChat(String chatRoomId, message) {
    requestMessages.doc(chatRoomId).collection('chats').add(message).catchError((e) {
      print(e.toString());
    });
    requestMessages.doc(chatRoomId).update({
      'lastChat': message['message'],
      'lastChatTime' : message['time'],
    });
  }

  getChat(chatRoomId) async {
    return messages.doc(chatRoomId).collection('chats').orderBy('time').snapshots();
  }

  getRequestChat(chatRoomId) async {
    return requestMessages.doc(chatRoomId).collection('chats').orderBy('time').snapshots();
  }

  Future<DocumentSnapshot> getProductDetails(id)async{
    DocumentSnapshot doc = await listings.doc(id).get();
    return doc;
  }

  Future<DocumentSnapshot> getRequestDetails(id)async{
    DocumentSnapshot doc = await requests.doc(id).get();
    return doc;
  }
}