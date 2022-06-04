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
            children: [
              SizedBox(
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
                        '$product_detail_description',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
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