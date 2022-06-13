import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference messages = FirebaseFirestore.instance.collection(
      'messages');
  CollectionReference listings = FirebaseFirestore.instance.collection(
    'listings');


  createChatRoom({chatData}) {
    // need change to  catch error
    FirebaseFirestore.instance.collection(
        'messages').doc(chatData['chatRoomId']).set(chatData).catchError((e) {
     //   'messages').doc().set(chatData).catchError((e) {
      print(e.toString());
    });
  }

  createChat(String chatRoomId, message) {
    FirebaseFirestore.instance.collection(
        'messages').doc(chatRoomId).collection('chats').add(message).catchError((e) {
      //  'messages').doc().collection('chats').add(message).catchError((e) {
      print(e.toString());
    });
    FirebaseFirestore.instance.collection(
      'messages').doc(chatRoomId).update({
      'lastChat': message['message'],
      'lastChatTime' : message['time'],

    });
//    messages.doc(chatRoomId).collection('chats').add(message).catchError((e) {
  //    print(e.toString());
  //  });
  }
  getChat(chatRoomId) async{
   return FirebaseFirestore.instance.collection(
       'messages').doc(chatRoomId).collection('chats').orderBy('time').snapshots();
      // 'messages').doc().collection('chats').orderBy('time').snapshots();
  }

  Future<DocumentSnapshot> getProductDetails(id)async{
    DocumentSnapshot doc = await listings.doc(id).get();
    return doc;
  }
}