import 'package:buyer_app/src/screens/explore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
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

 // DateTime timestamp = new DateTime.now();
  //String date = ('yyyy-MM-dd – hh:mm:a').format(timestamp);

  TextEditingController commentController = TextEditingController();
  buildComments() {
    return StreamBuilder(
        stream:
        commentRef.doc(widget.postID).collection('comments').
        snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
           List<Comment> comments = [];

          snapshot.data!.docs.forEach((doc) {

            comments.add(Comment.fromDocument(doc));

          });

          return ListView(children: comments);
        });
  }

  addComment() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    String buyerName = ds.get('Name');
    String profilePic = ds.get('Profile Pic');

    commentRef.doc(widget.postID).collection("comments").add(
      {
        "comment": commentController.text,
        "userId": _auth.currentUser!.uid,
        "name": buyerName,
        "profilePic": profilePic,
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
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
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
              title: TextFormField(
                controller: commentController,
                decoration: InputDecoration(labelText: " Write a comment..."),
              ),
              trailing: OutlinedButton(
                  onPressed: () => addComment(), child: Text("Post")),
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
 // final String timestamp;

  Comment({
    required this.userId,
    required this.comment,
    required this.name,
    required this.profilePic,
 //   required this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      userId: doc['userId'],
      comment: doc['comment'],
      name: doc['name'],
      profilePic: doc['profilePic'],
     // timestamp: doc['timestamp'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:

     Row(
 crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.fill,
           // image: !(Uri.tryParse(getImage())?.hasAbsolutePath ?? false)
             //  ? Image.asset('images/noProfilePic.png').image
               image: Image.network(profilePic).image,
          ),
        ),
      ),

         // Row(children:[
          Text(
            "  " + name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          Expanded(child:  Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text( comment, style: TextStyle(fontSize: 15)),
          ))

        ],
      ),
     /* Row(
        crossAxisAlignment: CrossAxisAlignment.center,
       children: [
          Container(
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
            //child: Image.network(profilePic),
          ),
         Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children:[
          Text(
            "  " + name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        //  Text("  " + comment, style: TextStyle(fontSize: 15)),
          Expanded(child:  Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text( comment, style: TextStyle(fontSize: 15)),
          )),
             ],),
        ],
      ),*/

    );
  }
}