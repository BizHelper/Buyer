import 'package:buyer_app/src/UserData.dart';
import 'package:buyer_app/src/buyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  final CollectionReference buyersCollection = FirebaseFirestore.instance.collection('buyers');

  Future updateUserData(String name) async {
    return await buyersCollection.doc(uid).set({
      'name': name,
    });
  }
  List<Buyer> _buyerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Buyer(
        // changed
    name: doc.get('name')?? ''
      );
      }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {

      return UserData(
      uid: uid,
          // changed function thingy
          name: snapshot.get('name'),
      );
  }

  Stream<QuerySnapshot> get buyer {
    return buyersCollection.snapshots();
  }
  Stream<UserData> get userData {
    return buyersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
}
}