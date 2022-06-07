import 'package:cloud_firestore/cloud_firestore.dart';

class Buyer {
  final String name;
  final String profilePic;

  Buyer({required this.name, required this.profilePic});

  factory Buyer.fromDocument(DocumentSnapshot doc) {
    return Buyer(
      name: doc['Name'], profilePic: doc['profilePic']
    );
  }
}
