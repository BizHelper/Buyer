import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:buyer_app/src/screens/myRequests.dart';
import 'package:buyer_app/src/screens/request.dart';

class RequestDescriptionScreen extends StatefulWidget {
  var buyerName;
  var sellerName;
  var category;
  var deadline;
  var description;
  var price;
  var title;
  var requestID;

  RequestDescriptionScreen({
    this.buyerName,
    this.sellerName,
    this.category,
    this.deadline,
    this.description,
    this.price,
    this.title,
    this.requestID,
  });

  @override
  State<RequestDescriptionScreen> createState() => _RequestDescriptionScreenState();
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
}

class _RequestDescriptionScreenState extends State<RequestDescriptionScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _sellerName = '';

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
                MaterialPageRoute(builder: (context) => RequestScreen()));
          },
        ),
        title: const Text(
          'Request Description',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$' + widget.price,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            /*  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'by ' + widget.buyerName,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

             */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Deadline: ' + widget.deadline,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*widget.sellerName == 'null' ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        final uid = AuthService().currentUser?.uid;
                        DocumentSnapshot ds = await FirebaseFirestore.instance.collection('sellers').doc(uid).get();
                        _sellerName = ds.get('Name');
                        DocumentReference dr = FirebaseFirestore.instance.collection('requests').doc(widget.requestID);
                        dr.update({'Seller Name' : _sellerName});
                        print(_sellerName);
                        print(widget.requestID);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RequestScreen()));
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.add_task,
                            size: 28.0,
                            color: Colors.green,
                          ),
                          Text(
                            'Accept Request',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ) :
              Container(),

               */
            ],
          ),
        ),
      ),
    );
  }
}