
import 'package:buyer_app/src/firebase_service.dart';
import 'package:buyer_app/src/screens/chat_conversation_screen.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthService.dart';
import '../widgets/products.dart';

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




  ProductDescriptionScreen(
      {this.productDetailName,
        this.productDetailShopName,
        this.productDetailPrice,
        this.productDetailCategory,
        this.productDetailDescription,
        this.productDetailImages,
        this.productDetailId,
        this.sellerId,
        this.listingId,
        required this.iconsButtons,
        required this.deleted,

      });

  @override
  State<ProductDescriptionScreen> createState() => _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseService _service = FirebaseService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String _buyerName = '';

  /*Future<String> getBuyerName() async {
    final uid = auth.currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    setState(() => _buyerName = ds.get('Name'));
    return _buyerName;
  }

  String getName() {
    getBuyerName();
    return _buyerName;
  }

   */

  @override
  Widget build(BuildContext context) {
    createChatRoom() async {
      final uid = auth.currentUser?.uid;
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
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
        'buyerName':_buyerName
      };

      List<String> users = [
        //provider.sellerId,
        widget.sellerId,
        _auth.currentUser!.uid
      ];

      String chatRoomId = '${widget.sellerId}.${_auth.currentUser!.uid}.${widget.listingId}';
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
          builder: (BuildContext context) => ChatConversations(
              chatRoomId: chatRoomId,type: 'listings'
          ),
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
            // 28.59 need change where seller cant press chat or sth
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
                    Text(
                      '${widget.productDetailName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                      style: const TextStyle(
                        fontSize: 15,
                      ),
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
                   widget.iconsButtons?
                   InkWell(
                      //  borderRadius:,
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
                    ): Container()
                  ],
                ),
              ),
              widget.deleted == 'true'?
                  Text(
                    '[DELETED]',
                    style: TextStyle(
                      color: Colors.red,
                    )): Container()
            ],
          ),
        ),
      ),
    );
  }
}