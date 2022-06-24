import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:buyer_app/src/widgets/categories.dart';
import 'package:buyer_app/src/widgets/navigateBar.dart';
import '../widgets/products.dart';
import 'chatscreen.dart';

class CategoryScreen extends StatefulWidget {
  var currentCategory;
  CategoryScreen({this.currentCategory});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: () {
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ChatScreen()));
          }, icon: Icon(Icons.chat)),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('listings')
            .where('Category', isEqualTo: widget.currentCategory).
          where('Deleted', isEqualTo: "false")
            //.where('Seller Name', isEqualTo: getName())

            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Padding(
                    padding: EdgeInsets.only(left: 11.0, top: 12,right: 0.0, bottom: 0.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(right: 11.0, top: 12),
                    child: TextButton(
                      child: Text('Favourites',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),onPressed:(){},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero,minimumSize:
                      Size.zero,tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  ),)
                ],
              ),
              Categories(
                currentCategory: widget.currentCategory,
              ),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: snapshot.data!.docs.map(
                        (listings) {
                      return Product(
                        prodName: listings['Name'],
                        prodShopName: listings['Seller Name'],
                        prodPrice: listings['Price'],
                        prodCategory: listings['Category'],
                        prodDescription: listings['Description'],
                        prodImage: listings['Image URL'],
                          sellerId: listings['Seller Id'],
                          listingId: listings['Listing ID'],
                        deleted: listings['Deleted'],
                      );
                    },
                  ).toList(),
                ),
              ),
              NavigateBar(),
            ],
          );
        },
      ),
    );
  }
}