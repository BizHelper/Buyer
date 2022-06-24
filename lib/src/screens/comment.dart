import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final commentRef = FirebaseFirestore.instance.collection('comments');
late CollectionReference buyersRef =
    FirebaseFirestore.instance.collection('buyers');
final FirebaseAuth _auth = FirebaseAuth.instance;

class CommentsScreen extends StatefulWidget {
  final String postID;
  CommentsScreen({required this.postID});
  @override
  State<CommentsScreen> createState() => CommentsScreenState();
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
}

class CommentsScreenState extends State<CommentsScreen> {
  bool _send = false;

  TextEditingController commentController = TextEditingController();
  buildComments() {
    return StreamBuilder(
      stream: commentRef
          .doc(widget.postID)
          .collection('comments')
          .orderBy('time')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        List<Comment> comments = [];
        snapshot.data!.docs.forEach(
          (doc) {
            comments.add(Comment.fromDocument(doc));
          },
        );
        return ListView(children: comments);
      },
    );
  }

  addComment() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    String buyerName = ds.get('Name');
    String profilePic = ds.get('Profile Pic');

    commentRef.doc(widget.postID).collection("comments").add(
      {
        "comment": commentController.text,
        "userId": _auth.currentUser!.uid,
        "name": buyerName,
        "profilePic": profilePic,
        'time': DateTime.now().microsecondsSinceEpoch,
        //  "timestamp": timestamp,
      },
    );
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        title: const Text(
          'Comment Section',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: " Write a comment..."),
            ),
            trailing: OutlinedButton(
              onPressed: () => addComment(),
              child: Text("Post"),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
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
    return Comment(
      userId: doc['userId'],
      comment: doc['comment'],
      name: doc['name'],
      profilePic: doc['profilePic'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.network(profilePic).image,
                ),
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                //text: 'Hi',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: name + '  ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: comment)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
