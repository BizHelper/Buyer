/*
import 'package:buyer_app/src/screens/home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatelessWidget {
  var product_detail_name;
  var product_detail_shopname;
  var product_detail_price;
  var product_detail_category;
  var product_detail_description;
  var product_detail_images;

  ProductDescriptionScreen(
      {this.product_detail_name,
      this.product_detail_shopname,
      this.product_detail_price,
      this.product_detail_category,
      this.product_detail_description,
      this.product_detail_images});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: const Text(
          'Prod Description',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //,
             // Container(child:
              Container(child: Image.network(this.product_detail_images, height: 300)),

            //  Row(children: [
               Row (
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                 Text(this.product_detail_name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                     Text(this.product_detail_name)
              ]),
              // Container(child: widget.product_detail_price)),

              Row(children: [
             //   Text('Price: ', style: TextStyle(fontSize: 17)),
                Text(this.product_detail_price, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
              ]),
              Flexible(child:
                Text("Description "+ this.product_detail_description)),
                    ,
              ),
            ],
          )),
    );
  }
}*/

/*
import 'package:buyer_app/src/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatelessWidget {
  var product_detail_name;
  var product_detail_shopname;
  var product_detail_price;
  var product_detail_category;
  var product_detail_description;
  var product_detail_images;
  ProductDescriptionScreen(
      {this.product_detail_name,
        this.product_detail_shopname,
        this.product_detail_price,
        this.product_detail_category,
        this.product_detail_description,
        this.product_detail_images});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: const Text(
          'Product Description',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 300,
                child: Image.network(this.product_detail_images),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product_detail_name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$$product_detail_price',
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
                        'by: $product_detail_shopname',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Text(
                        'Description: ', style: TextStyle(fontSize: 16),),
                    Text(product_detail_description,
                        style: TextStyle(fontSize: 16))]
                      ),
                    ),
                  ],
                ),
              ),

          ),
        );
  }
} */
//import 'dart:html';

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

ProductDescriptionScreen(
    {this.productDetailName,
      this.productDetailShopName,
      this.productDetailPrice,
      this.productDetailCategory,
      this.productDetailDescription,
      this.productDetailImages,
    this.productDetailId, this.sellerId,
      this.listingId
  });


/*
createChatRoom(Product provider) async {
  Map <String, dynamic> product = {
    'productDetailId': provider.prodId,
    'productDetailImages': provider.prodDescription,
    'productDetailPrice': provider.prodPrice,
    'productDetailName': provider.prodName,
  };

  List<String> users = [
    provider.sellerId,
  _auth.currentUser!.uid
  ];
  String chatRoomId = '${provider.sellerId}.${' _auth.currentUser!.uid'}.${provider.prodId}';
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
  //Navigator.push (
    // context,
    //MaterialPageRoute (
      //builder: (BuildContext context) => const ChatConversations(),
    //),
 // );

}


 */
/*
  createChatRoom() async {
    Map <String, dynamic> product = {
      'productDetailId': listingId,
      'productDetailImages': productDetailImages,
      'productDetailPrice': productDetailPrice,
      'productDetailName': productDetailName,
    };

    List<String> users = [
      //provider.sellerId,
      sellerId,
      _auth.currentUser!.uid
    ];
    String chatRoomId = '${sellerId}.${' _auth.currentUser!.uid'}.${listingId}';
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
    Navigator.push (
     context,
    MaterialPageRoute (
    builder: (BuildContext context) => const ChatConversations(),
    ),
     );

  }

 */


  @override
Widget build(BuildContext context) {
 //var product = Provider.of<Product> (context);
    createChatRoom() async {
      Map <String, dynamic> product = {
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
      Navigator.push (
        context,
        MaterialPageRoute (
          builder: (BuildContext context) =>  ChatConversations(
            chatRoomId: chatRoomId,
          ),
        ),
      );


      //Navigator.of(context).pushReplacement(
        //  MaterialPageRoute(
          //    builder: (context) => ChatConversations(chatRoomId: chatRoomId)));
    }
   return   Scaffold(
     backgroundColor: Colors.blueGrey[50],
     appBar: AppBar(
       centerTitle: true,
       backgroundColor: Colors.cyan.shade900,
       leading: IconButton(
         icon: Icon(Icons.arrow_back_rounded),
         onPressed: () {
           Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (context) => HomeScreen()));
         },
       ),
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

           // TextButton(child: (Text('Chat', style: TextStyle(fontSize:20, fontWeight:FontWeight.bold))),
             //  onPressed: createChatRoom,),
             Padding(
               padding: const EdgeInsets.only(right: 16),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   InkWell(
                   //  borderRadius:,
                     onTap:
                     createChatRoom,
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
                          //   fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.blue,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
          ],
         ),
       ),
     ),
   );
 }
}


