import 'package:buyer_app/src/screens/requestchat.dart';
import 'package:buyer_app/src/screens/requestform.dart';
import 'package:buyer_app/src/widgets/singlerequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import '../widgets/navigateBar.dart';
import 'package:buyer_app/src/services/authservice.dart';


class RequestScreen extends StatefulWidget {
  var type;
  RequestScreen({required this.type});
  @override
  State<RequestScreen> createState() => _RequestScreenState();

}

class _RequestScreenState extends State<RequestScreen> {
  final FirebaseAuth _auth = AuthService().auth;
  String _buyerName = '';

  Future<String> getBuyerName() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds =
    await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    setState(() => _buyerName = ds.get('Name'));
    return _buyerName;
  }

  String getName() {
    getBuyerName();
    return _buyerName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => RequestChatScreen()));
              },
              icon: Icon(Icons.chat)),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
        title: const Text(
          'Request',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream:
        widget.type == 'Pending'?
        FirebaseFirestore.instance
            .collection('requests')
            .where('Buyer Name', isEqualTo: getName())
            .where('Seller Name', isEqualTo: 'null')
            .where('Deleted', isEqualTo: 'false')
            .snapshots()
            : FirebaseFirestore.instance
            .collection('requests')
            .where('Buyer Name', isEqualTo: getName() )
            .where('Accepted', isEqualTo: 'true')
            .where('Deleted', isEqualTo: 'false')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Requests',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.orange[600])),
                      onPressed: () {
                        //  Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RequestFormScreen()));
                      },
                      child: const Text(
                        'Add New Request',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.type != "Pending"){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RequestScreen(type: 'Pending')));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(widget.type == "Pending"? Colors.amber: Colors.orange),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Pending Requests',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.type != "Accepted"){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RequestScreen(type: 'Accepted')));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(widget.type == "Accepted"? Colors.amber: Colors.orange),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Accepted Requests',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Flexible(
                child: ListView(
                  children: snapshot.data!.docs.map(
                        (requests) {
                      return SingleRequest(
                        buyerName: requests['Buyer Name'],
                        sellerName: requests['Seller Name'],
                        category: requests['Category'],
                        deadline: requests['Deadline'],
                        description: requests['Description'],
                        price: requests['Price'],
                        title: requests['Title'],
                        requestID: requests['Request ID'],
                        buyerID: requests['Buyer ID'],
                        deleted: requests['Deleted'],
                      );
                    },
                  ).toList(),
                ),
              ),
              NavigateBar()
            ],
          );
        },
      ),
    );
  }
}