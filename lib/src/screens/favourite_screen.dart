import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _auth = AuthService().auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
        actions: <Widget>[
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
          'Favourites',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Favourites')
            .doc(_auth.currentUser!.uid)
            .collection('items')
         //   .where('liked', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
              List<Favourites> favourites = [];
              snapshot.data!.docs.forEach((doc) {
                favourites.add(Favourites.fromDocument(doc));
              });
              return ListView(children: favourites);
          }
        }
      ),
    );
  }
}

class Favourites extends StatelessWidget {
  final String sellerName;
  final String itemName;
  final String itemImage;
  final String price;
  final String category;
  final String description;
  final String productDetailId;
  final String sellerId;
  final bool iconsButton;
  final String deleted;

  Favourites({
    required this.sellerName,
    required this.price,
    required this.itemName,
    required this.itemImage,
    required this.category,
    required this.description,
    required this.productDetailId,
    required this.sellerId,
    required this.iconsButton,
    required this.deleted,
  });

  factory Favourites.fromDocument(DocumentSnapshot doc) {
    return Favourites(
      sellerName: doc['seller name'],
      price: doc['price'],
      itemName: doc['name'],
      itemImage: doc['images'],
      category: doc['category'],
      description: doc['description'],
      iconsButton: doc['icon button'],
      productDetailId: doc['product detail id'],
      sellerId: doc['seller id'],
      deleted: doc['deleted'],
    );
  }
  Future removeFromFavourite() async {
    var currentUser = AuthService().currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Favourites');
    return _collectionRef
        .doc(currentUser!.uid)
        .collection('items').doc(productDetailId)
        .delete();
    //.update({'liked': false});
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProductDescriptionScreen(
                  productDetailName: itemName,
                  productDetailShopName: sellerName,
                  productDetailPrice: price,
                  productDetailCategory: category,
                  productDetailDescription: description,
                  productDetailImages: itemImage,
                  productDetailId: productDetailId,
                  sellerId: sellerId,
                  listingId: productDetailId,
                  iconsButtons: iconsButton,
                  deleted: deleted))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(itemImage),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(itemName), Text(sellerName), Text(price)],
                    ),
                  ),
                  IconButton(onPressed: removeFromFavourite, icon: Icon(Icons.delete))
                ],
              ),
              Divider(height: 5.0, color: Colors.black)
            ],
          ),
        ),
      ),
    );
    /* ListTile(
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
                  image: Image.network(itemImage).image,
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
                      text: itemName + '  ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: sellerName),
                  TextSpan(text: price),
                ],
              ),
            ),
          ),
        ],
      ),
    );*/
  }
}
