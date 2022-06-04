
import 'package:buyer_app/src/authservice.dart';
import 'package:buyer_app/src/products.dart';
import 'package:buyer_app/src/screens/Popular.screen.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:buyer_app/src/screens/womenclothingscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:provider/provider.dart';
import 'accessories.dart';
import 'bagsandwalletscreen.dart';
import 'foodandBeverageScreen.dart';
import 'menclothingscreen.dart';
import 'othersscreen.dart';

class ToysandGames extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late var prod_name = '';
  late var prod_shopname='';
  late var prod_price= '';
  late var prod_description = '';
  late var prod_category = '';
  late var prod_image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        // stream: listings.snapshots(),
        stream: FirebaseFirestore.instance.collection('listings')
            .where('Category', isEqualTo: 'Toys & Games').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12, top: 11),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => PopularScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.amber,
                      child: const Text(
                        "Popular",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => BagAndWalletScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "Bags & Wallets",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => WomenClothingScreen()));},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "Women clothing",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MenClothingScreen()));},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "Men clothing",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => FoodAndBeverageScreen()));},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "Food & Beverage",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AccessoriesScreen()));},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "Accessories",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ToysandGames()));},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "Toys & Games",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => OthersScreen()));},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: const Text(
                        "  Others  ",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              //ListView(
              //  Container(width: 1000, height: 10,child: Text('hi')),
              Flexible(
                child: Container(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.docs.map(
                          (listings) {
                        /*  prod_name = Text(listings['Name']);
                            prod_shopname = Text(listings['Seller Name']);
                            prod_price = Text(listings['Price']);

                           */

                        return Center(

                          child: Card(
                            child: Hero(
                              tag: Text(listings['Name']),
                              //  tag: (prod_name),
                              child: Material(
                                child: InkWell(
                                  onTap: (){
                                    prod_name = listings['Name'];
                                    prod_shopname = (listings['Seller Name']);
                                    prod_price = (listings['Price']);
                                    prod_category = (listings['Category']);
                                    prod_description = listings['Description'];
                                    prod_image = listings['Image URL'];
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => new ProductDescriptionScreen(
                                          product_detail_name: prod_name,
                                          product_detail_shopname: prod_shopname,
                                          product_detail_price:  prod_price,
                                          product_detail_category: prod_category,
                                          product_detail_description: prod_description,
                                          product_detail_images: prod_image,
                                        )));
                                  },
                                  child: GridTile(
                                      footer: Container(
                                        color: Colors.white70,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 16,
                                                      //  right: 16,
                                                      top: 4,
                                                      bottom: 4),
                                                  child: Text(listings['Name'],
                                                    //Text('$prod_name'),
                                                    //  Text(
                                                    //  prod_name,
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  //Text(
                                                  //listings['Name'],


                                                  //style: TextStyle(
                                                  //    fontWeight:
                                                  //  FontWeight.bold),

                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                    //    left: 16,
                                                      right: 16,
                                                      top: 4,
                                                      bottom: 4),
                                                  child:
                                                  /*Text(
                                                    listings['Price'],
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 16,
                                                    ),
                                                  ),

                                                   */
                                                  //  prod_price,
                                                  Text(
                                                    listings['Price'],
                                                    //"\$prod_price",
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  top: 4,
                                                  bottom: 4),
                                              child:
                                              //Text(
                                              //(listings['Seller Name']),
                                              //style: const TextStyle(
                                              //color: Colors.black54,
                                              //fontWeight: FontWeight.w800,
                                              //),
                                              //),
                                              // prod_shopname,
                                              Text(
                                                listings['Seller Name'],
                                                //'prod_shopname',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            //  ),

                                          ],
                                        ),
                                      ),
                                      child: Image.network(
                                        // 'https://googleflutter.com/sample_image.jpg'),
                                          listings['Image URL'])
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Container(
                //   height: 100,
                // width: 500,
                child: Column(
                  children: [
                    Divider(height: 1, color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 55,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ExploreScreen()));
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.explore),
                                  Text('Explore'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => RequestScreen()));
                              },
                              child: Column(
                                children: const [
                                  const Icon(Icons.sticky_note_2),
                                  Text('Request'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.home),
                                  Text('Home'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LocationScreen()));
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.location_on),
                                  Text('location'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: const [
                                  Icon(Icons.account_box),
                                  Text('Account'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    //},),
//    );
  }
}
