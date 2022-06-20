
import 'package:buyer_app/src/firebase_service.dart';
import 'package:buyer_app/src/screens/chat_conversation_screen.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _service = FirebaseService();

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
        required this.deleted});

  @override
  Widget build(BuildContext context) {
    createChatRoom() async {
      Map<String, dynamic> product = {
        'productDetailId': listingId,
        'productDetailImages': productDetailImages,
        'productDetailPrice': productDetailPrice,
        'productDetailName': productDetailName,
        'productDetailShopName': productDetailShopName,
        'productDetailCategory': productDetailCategory,
        'productDetailDescription': productDetailDescription,
        'sellerId': sellerId,
        'listingId': listingId,
      };

      List<String> users = [
        //provider.sellerId,
        sellerId,
        _auth.currentUser!.uid
      ];

      String chatRoomId = '${sellerId}.${_auth.currentUser!.uid}.${listingId}';
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
                child: Image.network(this.productDetailImages),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$productDetailName',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$$productDetailPrice',
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
                      'by: $productDetailShopName',
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
                        '$productDetailDescription',
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
                   iconsButtons?
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
              deleted == 'true'?
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