/*
import 'package:buyer_app/src/screens/explore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/home.dart';

import '../AuthService.dart';
import '../buyer.dart';

final commentRef = FirebaseFirestore.instance.collection('comments');
late CollectionReference buyersRef = FirebaseFirestore.instance.collection('buyers');
final FirebaseAuth _auth = FirebaseAuth.instance;




class Comments extends StatefulWidget {
  //const Comments({Key? key}) : super(key: key);

  final String postId;

Comments({
    required this.postId}
);
  @override
  State<Comments> createState() => CommentsState(
    postId : this.postId,
  );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController  = TextEditingController();
  final String postId;
  CommentsState({
    required this.postId,
});
  buildComments() {
    return StreamBuilder(
      stream: commentRef.doc(postId).collection('comments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
            //here is suppose return circularprogress.
          }

          List<Comment> comments = [];
          snapshot.data!.docs.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return
            ListView(children: comments);
        });
  }
/*
   getName() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').
    doc(uid).get();
    String buyerName = ds.get('Name');
  }

  String getBuyerName() {
    getName();
    return _buyerName
  }

 */

   addComment() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    String buyerName = ds.get('Name');
   //String profilePic = ds.get('profilePic');
    String test = ds.get('test');


    commentRef.doc(postId).collection("comments").add({
     // "username": _auth.currentUser!.displayName,
      "comment": commentController.text,
      //havent added timestamp
      "userId": _auth.currentUser!.uid,
      "name": buyerName,
    //  "profilePic": profilePic,
      "test": test,
     // "userId" : currentUser.uid,
    },);
    commentController.clear();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.cyan.shade900,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              // a problem it navigate back twice to explore screen...
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ExploreScreen()));
            },
          ),
          title: const Text(
            'Comment Section',
            style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
          ),
        ),
      body: Column(
        children: <Widget> [
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: " Write a comment..."),

            ),
            trailing: OutlinedButton(onPressed: ()=> addComment(),
            child: Text("Post")),
          )
        ],
      )
    );
  }
}

class Comment extends StatelessWidget {
//  final String username;
  //havent added username and timestamps
  final String userId;
  final String comment;
  final String name;
  //final String test;
// final String profilePic;


  Comment({
    required this.userId,
    required this.comment,
    required this.name,
   // required this.test,
  // required this.profilePic,
});
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment (
      userId: doc['userId'], comment: doc['comment'],name: doc['name'],
   // test: doc['test'],
    //  profilePic: doc['profilePic'],
    );
  }
  @override
  Widget build(BuildContext context) {
    return
        ListTile(
          title:
          Column(children:
              [
        //        Image.network(profilePic),
           Text(comment),]),
          subtitle: Text(name),

        );
  }
}
*/

import 'package:buyer_app/src/screens/explore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/home.dart';

import '../AuthService.dart';
import '../buyer.dart';

final commentRef = FirebaseFirestore.instance.collection('comments');
late CollectionReference buyersRef = FirebaseFirestore.instance.collection('buyers');
final FirebaseAuth _auth = FirebaseAuth.instance;


class Comments extends StatefulWidget {
  //const Comments({Key? key}) : super(key: key);

  final String postId;

  Comments({
    required this.postId}
      );
  @override
  State<Comments> createState() => CommentsState(
    postId : this.postId,
  );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController  = TextEditingController();
  final String postId;
  CommentsState({
    required this.postId,
  });
  buildComments() {
    return StreamBuilder(
        stream: commentRef.doc(postId).collection('comments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
            //here is suppose return circularprogress.
          }

          List<Comment> comments = [];
          snapshot.data!.docs.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return
            ListView(children: comments);
        });
  }
/*
   getName() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').
    doc(uid).get();
    String buyerName = ds.get('Name');
  }
  String getBuyerName() {
    getName();
    return _buyerName
  }
 */

  addComment() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').
    doc(uid).get();
    String buyerName = ds.get('Name');
    String profilePic = ds.get('profilePic');


    commentRef.doc(postId).collection("comments").add({
      // "username": _auth.currentUser!.displayName,
      "comment": commentController.text,
      //havent added timestamp
      "userId": _auth.currentUser!.uid,
      "name": buyerName,
      "profilePic": profilePic,

      // "userId" : currentUser.uid,
    },);
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.cyan.shade900,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              // a problem it navigate back twice to explore screen...
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ExploreScreen()));
            },
          ),
          title: const Text(
            'Comment Section',
            style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: <Widget> [
            Expanded(child: buildComments()),
            Divider(),
            ListTile(
              title: TextFormField(
                controller: commentController,
                decoration: InputDecoration(labelText: " Write a comment..."),

              ),
              trailing: OutlinedButton(onPressed: ()=> addComment(),
                  child: Text("Post")),
            )
          ],
        )
    );
  }
}

class Comment extends StatelessWidget {
//  final String username;
  //havent added username and timestamps
  final String userId;
  final String comment;
  final String name;
  final String profilePic;

  Comment({
    required this.userId,
    required this.comment,
    required this.name,
    required this.profilePic,

  });
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment (
      userId: doc['userId'], comment: doc['comment'],name: doc['name'],
      profilePic: doc['profilePic'],
    );
  }
  @override
  Widget build(BuildContext context) {
    return
      ListTile(
        //title:
        //Text(comment, style: TextStyle(fontSize: 20)),

        title:

        Row(children:[
        Container(width: 50, child: Image.network(profilePic)),
          Text("  " + name,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          Text("  " + comment, style: TextStyle(fontSize:15)),]),

      );
  }
}