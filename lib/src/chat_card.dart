import 'package:buyer_app/src/firebase_service.dart';
import 'package:buyer_app/src/screens/chat_conversation_screen.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
final Map<String, dynamic> chatData;
ChatCard(this.chatData);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
 // FirebaseService _service = FirebaseService();
  //  DocumentSnapshot? doc;
  /*getProductDetails() {
    _service.getProductDetails(widget.chatData['product']['productDetailId']).then((value){
      setState((){
        doc = value;
      });
    });
  }

   */


  @override
  Widget build(BuildContext context) {
   // getProductDetails();
   // return doc == null?
     //   Container():
    return Container(
      child: ListTile(
        onTap: (){
          Navigator.push (
            context,
            MaterialPageRoute (
              builder: (BuildContext context) =>  ChatConversations(chatRoomId: widget.chatData['chatRoomId'],
              type: 'listings'),
            ),
          );


       //   Navigator.of(context).pushReplacement(
         //    MaterialPageRoute(
           //       builder: (context) => ChatConversations(chatRoomId: widget.chatData['chatRoomId'])));
        },
     //   leading: SizedBox(child: Image.network(doc!['Image URL']),width: 50,height: 50),
        leading: SizedBox(child: Image.network(widget.chatData['product']['productDetailImages'], height: 50, width: 50)),
        title: Text(widget.chatData['product']['productDetailName']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$' + widget.chatData['product']['productDetailPrice'], maxLines: 1),
          ],
        ),
       /* title: Text(doc!['Name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(doc!['Description'], maxLines: 1),
            Text('\$'+ doc!['Price'], maxLines: 1),
          //  if(widget.chatData['lastChat']!= null)
            //  Text(widget.chatData['lastChat'], maxLines: 1, style: TextStyle(fontSize: 10))
          ],
        ),
        */
        trailing: InkWell(
          onTap: () {

            Navigator.of( context).push(
                MaterialPageRoute(
                    builder: (context) => ProductDescriptionScreen(
                    productDetailName: widget.chatData['product']['productDetailName'],
                    productDetailId: widget.chatData['product']['productDetailId'],
                    productDetailCategory: widget.chatData['product']['productDetaillId'],
                    productDetailDescription: widget.chatData['product']['productDetailDescription'],
                    productDetailImages: widget.chatData['product']['productDetailImages'],
                    productDetailPrice: widget.chatData['product']['productDetailPrice'],
                    productDetailShopName:widget.chatData['product']['productDetailShopName'] ,
                    sellerId: widget.chatData['product']['sellerId'] ,
                    listingId:widget.chatData['product']['listingId'] )));

          },

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  Icons.visibility,
                  size: 22.0,
                  color: Colors.red[900],
                ),
            Text('View Listing',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey), )
      ),
    );
  }
}
