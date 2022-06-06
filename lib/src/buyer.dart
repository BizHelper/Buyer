import 'package:cloud_firestore/cloud_firestore.dart';

class Buyer {
  final String name;

  Buyer({required this.name});

  factory Buyer.fromDocument(DocumentSnapshot doc) {
    return Buyer(
      name: doc['Name'],
    );
  }
}
