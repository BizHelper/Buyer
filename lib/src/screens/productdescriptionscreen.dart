
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

   ProductDescriptionScreen({this.product_detail_name, this.product_detail_shopname, this.product_detail_price,
   this.product_detail_category, this.product_detail_description, this.product_detail_images});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar:
    AppBar(
      centerTitle: true,
      backgroundColor: Colors.cyan.shade900,
       actions: <Widget>[
       IconButton(onPressed: () {}, icon: Icon(Icons.search)),

    ],
      leading:   IconButton(
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
      child:
     // Column(
      //  crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //children: [Container(child: Image.network(this.product_detail_images)),
      Column(

        crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
        //,
            Container(child: Image.network(this.product_detail_images)),

          Row( children: [ Text('Product Name : ', style: TextStyle(fontSize: 17),),
      Text(this.product_detail_name, style: TextStyle(fontSize: 17))]),
   // Container(child: widget.product_detail_price)),

      Row(children: [Text('Price: ',style: TextStyle(fontSize: 17))
      ,Text(this.product_detail_price, style: TextStyle(fontSize: 17))]),
        Row(children: [Text('Category: ',style: TextStyle(fontSize: 17))
      ,Text(this.product_detail_category, style: TextStyle(fontSize: 17))]),
        Row(children: [Text('Description: ', style: TextStyle(fontSize: 17)),
          Text(this.product_detail_description, style: TextStyle(fontSize: 17))]),
            Row(children: [Text('Shop Name: ', style: TextStyle(fontSize: 17)),
              Text(this.product_detail_shopname, style: TextStyle(fontSize: 17))]),
   ],)
    ),);



    //body:
    //return StreamBuilder(
      //stream: FirebaseFirestore.instance.collection('listings')
        //.where('Name', isEqualTo: '').snapshots(),
        //builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
   // body: return Container();
   // GridView.count(
    //crossAxisCount: 2,
    //children: snapshot.data!.docs.map(
    //(listings) {
   // return
    //Center(child: Column(children: [
  //  Text(listings["Name"]),
    //Text(listings["Seller Name"],)
   // Text('hi');
   // ]));
   // }).toList());

  }
}


