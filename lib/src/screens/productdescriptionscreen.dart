import 'dart:collection';

import 'package:buyer_app/src/screens/sellerlistingpage.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:buyer_app/src/services/firebase_service.dart';
import 'package:buyer_app/src/screens/chat_conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatefulWidget {
  var productDetailName;
  var productDetailShopName;
  var productDetailPrice;
  var productDetailCategory;
  var productDetailDescription;
  var productDetailImages;
  var productDetailId;
  var sellerId;
  var listingId;
  var deleted;
  var iconsButtons;

  ProductDescriptionScreen({
    required this.productDetailName,
    required this.productDetailShopName,
    required this.productDetailPrice,
    required this.productDetailCategory,
    required this.productDetailDescription,
    required this.productDetailImages,
    required this.productDetailId,
    required this.sellerId,
    required this.listingId,
    required this.iconsButtons,
    required this.deleted,
  });

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  final FirebaseService _service = FirebaseService();
  final FirebaseAuth auth = AuthService().auth;
  String _buyerName = '';
  String uid = '';
  showAlertDialog(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text(
        'Added listing to favourites successfully',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );
  }
/*  Future addToFavourite() async {
    var currentUser = AuthService().currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Favourites');
    DocumentReference dr = _collectionRef.doc(currentUser!.uid).collection('items').doc();
    uid = dr.id;
   DocumentSnapshot ds = await _collectionRef.doc(currentUser!.uid).collection('items').doc(uid).get();

   if(ds!=null) {
   /*  if (ds.get("name") == "5") {
       return _collectionRef
           .doc(currentUser!.uid)
           .collection('items')
           .doc(uid)
           .update({'liked': true});
     } else

    */
  //   {
       return _collectionRef
           .doc(currentUser!.uid)
           .collection('items')
           .doc(uid)
           .update({'liked': false});
  //   }


  //  }
  /*  uid = dr.id;
    print(uid);
    return
      dr.set({
      "name": widget.productDetailName,
      "price": widget.productDetailPrice,
      "images": widget.productDetailImages,
      "seller name": widget.productDetailShopName,
      "product detail id": widget.listingId,
      "category": widget.productDetailCategory,
      "description": widget.productDetailDescription,
      "seller id": widget.sellerId,
      "icon button": widget.iconsButtons,
      "deleted": widget.deleted,
      "liked": true,
   //   "uid": dr.id,
    }).then((value) => print("add to favourites"));

   */
  }

 */
  Future addToFavourite() async {
    var currentUser = AuthService().currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Favourites');
    DocumentReference dr = _collectionRef
        .doc(currentUser!.uid)
        .collection('items')
        .doc(widget.listingId);
    uid = dr.id;
    //return
    /* dr.set(
        {
          "name": widget.productDetailName,
          "price": widget.productDetailPrice,
          "images": widget.productDetailImages,
          "seller name": widget.productDetailShopName,
          "product detail id": widget.listingId,
          "category": widget.productDetailCategory,
          "description": widget.productDetailDescription,
          "seller id": widget.sellerId,
          "icon button": widget.iconsButtons,
          "deleted": widget.deleted,
          "liked": true,
        }
    ).then((value) => print("add to favourites"));
      */
    Map<String, Object> fav = new HashMap();
    fav.putIfAbsent("name", () => widget.productDetailName);
    fav.putIfAbsent("price", () => widget.productDetailPrice);
    fav.putIfAbsent("images", () => widget.productDetailImages);
    fav.putIfAbsent(
      "seller name",
      () => widget.productDetailShopName,
    );
    fav.putIfAbsent(
      "product detail id",
      () => widget.listingId,
    );
    fav.putIfAbsent("category", () => widget.productDetailCategory);
    fav.putIfAbsent(
      "description",
      () => widget.productDetailDescription,
    );
    fav.putIfAbsent("seller id", () => widget.sellerId);
    fav.putIfAbsent(
      "icon button",
      () => widget.iconsButtons,
    );
    fav.putIfAbsent("deleted", () => widget.deleted);
    dr.set(fav);
  }

  Future removeFromFavourite() async {
    var currentUser = AuthService().currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Favourites');
    print(uid);
    return _collectionRef
        .doc(currentUser!.uid)
        .collection('items')
        .doc(widget.listingId)
        .delete();
    //.update({'liked': false});
  }

  @override
  Widget build(BuildContext context) {
    createChatRoom() async {
      final uid = auth.currentUser?.uid;
      DocumentSnapshot ds =
          await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
      setState(() => _buyerName = ds.get('Name'));
      Map<String, dynamic> product = {
        'productDetailId': widget.listingId,
        'productDetailImages': widget.productDetailImages,
        'productDetailPrice': widget.productDetailPrice,
        'productDetailName': widget.productDetailName,
        'productDetailShopName': widget.productDetailShopName,
        'productDetailCategory': widget.productDetailCategory,
        'productDetailDescription': widget.productDetailDescription,
        'sellerId': widget.sellerId,
        'listingId': widget.listingId,
        'buyerName': _buyerName
      };
      List<String> users = [widget.sellerId, auth.currentUser!.uid];
      String chatRoomId =
          '${widget.sellerId}.${auth.currentUser!.uid}.${widget.listingId}';
      Map<String, dynamic> chatData = {
        'users': users,
        'chatRoomId': chatRoomId,
        'product': product,
        'lastChat': null,
        'lastChatTime': DateTime.now().microsecondsSinceEpoch,
      };
      _service.createChatRoom(
        chatData: chatData,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ChatConversations(chatRoomId: chatRoomId, type: 'listings'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        title: const Text(
          'Product Description',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Image.network(this.widget.productDetailImages),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${widget.productDetailName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '\$${widget.productDetailPrice}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'by: ${widget.productDetailShopName}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            //'by: ${widget.productDetailShopName}',
                            'Visit Shop',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SellerListingPageScreen(
                                currentCategory: 'Popular',
                                sort: 'Default',
                                sellerName: widget.productDetailShopName,
                              ),
                            ),
                          );
                        }
                        //sellerId: widget.sellerId)));}
                        ),
                  ],
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
                        '${widget.productDetailDescription}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: (){
                          addToFavourite();
                        showAlertDialog(context);
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.add_circle,
                              size: 28.0,
                              color: Colors.red,
                            ),
                            Text(
                              'Favourites',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.iconsButtons
                        ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: InkWell(
                              onTap: createChatRoom,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 28.0,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    'Chat',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        )
                        : Container(),

                    // IconButton(onPressed: removeFromFavourite, icon: Icon(Icons.cancel))
                  ],
                ),
              ),
              widget.deleted == 'true'
                  ? Text(
                      '[DELETED]',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
