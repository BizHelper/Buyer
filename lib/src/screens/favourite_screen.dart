/*import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
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
            .collection('items').where("deleted", isEqualTo: "false")
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

class Favourites extends StatefulWidget {
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

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {


  Future removeFromFavourite() async {
    var currentUser = AuthService().currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Favourites');
    return _collectionRef
        .doc(currentUser!.uid)
        .collection('items').doc(widget.productDetailId)
        .delete();
    //.update({'liked': false});
  }

  String delete = '';

  Future<String> del() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('listings').doc(widget.productDetailId).get();
    setState(()=> delete = ds.get('Deleted'));
    return delete;
  }

  String getDeleted() {
    del();
    return delete;
  }


  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDescriptionScreen(
                  productDetailName: widget.itemName,
                  productDetailShopName: widget.sellerName,
                  productDetailPrice: widget.price,
                  productDetailCategory: widget.category,
                  productDetailDescription: widget.description,
                  productDetailImages: widget.itemImage,
                  productDetailId: widget.productDetailId,
                  sellerId: widget.sellerId,
                  listingId: widget.productDetailId,
                  iconsButtons: widget.iconsButton,
                  deleted: widget.deleted))),
          child:
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          SizedBox(child: Image.network(widget.itemImage),),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               //   Image.network(widget.itemImage),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(widget.itemName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(widget.sellerName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text("\$"+ widget.price),
                        ),
                        getDeleted() == 'true' ?
                        const Text(
                          '[DELETED LISTING]',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ) :
                        Container(),
                      ],
                    ),
                  ),
                 // IconButton(onPressed: removeFromFavourite, icon: Icon(Icons.delete))
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                    removeFromFavourite();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 28.0,
                            color: Colors.red[900],
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
}*/

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
              .collection('items').where("deleted", isEqualTo: "false")
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

class Favourites extends StatefulWidget {
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

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {


  Future removeFromFavourite() async {
    var currentUser = AuthService().currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Favourites');
    return _collectionRef
        .doc(currentUser!.uid)
        .collection('items').doc(widget.productDetailId)
        .delete();
    //.update({'liked': false});
  }

  String delete = '';

  Future<String> del() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('listings').doc(widget.productDetailId).get();
    setState(()=> delete = ds.get('Deleted'));
    return delete;
  }

  String getDeleted() {
    del();
    return delete;
  }


  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDescriptionScreen(
                  productDetailName: widget.itemName,
                  productDetailShopName: widget.sellerName,
                  productDetailPrice: widget.price,
                  productDetailCategory: widget.category,
                  productDetailDescription: widget.description,
                  productDetailImages: widget.itemImage,
                  productDetailId: widget.productDetailId,
                  sellerId: widget.sellerId,
                  listingId: widget.productDetailId,
                  iconsButtons: widget.iconsButton,
                  deleted: widget.deleted))),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Image.network(widget.itemImage,width: 300,height: 300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               //   Image.network(widget.itemImage),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(widget.itemName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(widget.sellerName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text("\$"+ widget.price),
                        ),
                        getDeleted() == 'true' ?
                        const Text(
                          '[DELETED LISTING]',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ) :
                        Container(),
                      ],
                    ),
                  ),
                  // IconButton(onPressed: removeFromFavourite, icon: Icon(Icons.delete))
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        removeFromFavourite();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 28.0,
                            color: Colors.red[900],
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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


