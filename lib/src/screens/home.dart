import 'package:buyer_app/src/screens/chatscreen.dart';
import 'package:buyer_app/src/widgets/categories.dart';
import 'package:buyer_app/src/widgets/navigateBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import '../widgets/products.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChatScreen()));
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
          'Home',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('listings')
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 11),
                    child: Text(
                      'Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 11.0, top: 12),
                    child: TextButton(
                      child: Text(
                        'Favourites',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    ),
                  ),
                ],
              ),
              Categories(currentCategory: "Popular"),
              Flexible(
                child: Container(
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
              ),
              NavigateBar(),
            ],
          );
        },
      ),
    );
  }
}
