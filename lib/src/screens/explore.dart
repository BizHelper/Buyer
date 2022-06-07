/*
import 'package:buyer_app/src/products.dart';

import 'package:buyer_app/src/screens/account.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:video_player/video_player.dart';

class ExploreScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    StreamBuilder(

    // stream: listings.snapshots(),
    stream: FirebaseFirestore.instance.collection('listings').snapshots(),
    //.where('product name', isEqualTo: 'tryout').snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Container();
      }

      return

        Column(
          children: [
            Flexible(
              child:
              GridView.count(
                // PageView(
                crossAxisCount: 2,
                children: snapshot.data!.docs.map(
                      (postings) {
                    return Center(

                      child: Card(
                        child: Hero(
                          tag: Text(postings['Seller Name']),
                          //  tag: (prod_name),
                          child: Material(
                            child: GridTile(
                              footer: Container(
                                  color: Colors.white70,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      //mainAxisAlignment:
                                      // MainAxisAlignment.spaceBetween,
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            //  right: 16,
                                            top: 4,
                                            bottom: 4),
                                        child: Text(postings['Description'],
                                          //Text('$prod_name'),
                                          //  Text(
                                          //  prod_name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //Text(
                                        //listings['Name'],


                                        //style: TextStyle(
                                        //    fontWeight:
                                        //  FontWeight.bold),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 4,
                                            bottom: 4),
                                        child:
                                        Text(
                                          postings['Seller Name'],
                                          //'prod_shopname',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 4,
                                            bottom: 4),
                                        child:
                                        Text(
                                          postings['Seller Name'],
                                          //'prod_shopname',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      //  ),
                                    ],)
                                //  child: Image.network(
                                // VideoPlayerController.network('https://www.fluttercampus.com/video.mp4')
                                //listings['Image URL'])
                                // fit: BoxFit.cover,
                              ), child: Image.network(

                         'https://googleflutter.com/sample_image.jpg'
                               // 'https://youtu.be/_dWt8B6bFnw?list=TLPQMDQwNjIwMjLvnDfltlHRtw'

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

            Column(
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
                          onTap: () {},
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
                                    builder: (context) => LocationScreen()));
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
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => AccountScreen()));
                          },
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
          ],
        );
    }
    ),],),);
  }
}*/



/*
import 'package:buyer_app/src/authservice.dart';
import 'package:buyer_app/src/products.dart';
import 'package:buyer_app/src/screens/Popular.screen.dart';
import 'package:buyer_app/src/screens/commentsection.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:buyer_app/src/screens/toysandgamesscreen.dart';
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
import 'package:video_player/video_player.dart';

class ExploreScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
//VideoPlayer controller;
//var comments = '';
//var sellerName = '';
//var description = '';

/*
  var productDetailName = '';
  var productDetailShopName = '';
  var productDetailPrice = '';
  var productDetailCategory = '';
  var productDetailDescription = '';
  var productDetailImages ='';

 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
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
          'Home',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(

        // stream: listings.snapshots(),
        stream: FirebaseFirestore.instance.collection('postings').snapshots(),
        //.where('product name', isEqualTo: 'tryout').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Container();
          }
          return
            Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Flexible(
                child: Container(

                  child:
                  GridView.count(
                    // PageView(
                    crossAxisCount: 1,
                    children: snapshot.data!.docs.map(
                          (postings) {
                        /*  prod_name = Text(listings['Name']);
                            prod_shopname = Text(listings['Seller Name']);
                            prod_price = Text(listings['Price']);

                           */

                        return Center(

                          child: Card(
                            child: Hero(
                              tag: Text(postings['Seller Name ']),
                              //  tag: (prod_name),
                              child: Material(
                                child: InkWell(
                                  onTap: (){
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
                                                  child: Text(postings['Seller Name '],
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
                                                    postings['Seller Name '],
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
                                                postings['Description '],
                                                //'prod_shopname',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                         //   TextButton(child: Text('Add comment'),
                                           //   onPressed: () {
                                                // FirebaseFirestore.instance.collection('postings').add({'comments': 'hi'});})
                                               // comments = 'hi';
                                            //    Text(postings['comments']) = Text('hi');
                                            //    Navigator.of(context).pushReplacement(
                                              //      MaterialPageRoute(builder: (context) => new CommentSectionScreen(
                                                //  description : description,
                                                  //sellerName: sellerName ,
                                                  //comments: 'test',
                                                //),),);

                                             // }
                                    //        ),
                                    ],
                                        ),
                                      ),

                                      child: Image.network(
                                       'https://googleflutter.com/sample_image.jpg'),
                                          //['Image URL'])
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
}*/

import 'package:buyer_app/src/authservice.dart';
import 'package:buyer_app/src/products.dart';
import 'package:buyer_app/src/screens/Popular.screen.dart';
import 'package:buyer_app/src/screens/comment.dart';
import 'package:buyer_app/src/screens/explore.dart';
import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/location.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:buyer_app/src/screens/request.dart';
import 'package:buyer_app/src/screens/toysandgamesscreen.dart';
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

class ExploreScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  late var prod_name = '';
  late var prod_shopname='';
  late var prod_price= '';
  late var prod_description = '';
  late var prod_category = '';
  late var prod_image = '';


/*
  var productDetailName = '';
  var productDetailShopName = '';
  var productDetailPrice = '';
  var productDetailCategory = '';
  var productDetailDescription = '';
  var productDetailImages ='';

 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        /*actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],

         */
        title: const Text(
          'Explore Page',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(

        // stream: listings.snapshots(),
        stream: FirebaseFirestore.instance.collection('postings').snapshots(),

        //.where('product name', isEqualTo: 'tryout').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Container();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(

                  child:
                  GridView.count(
                    // PageView(
                    crossAxisCount: 1,
                    children: snapshot.data!.docs.map(
                          (postings) {
                        return Center(

                          child: Card(
                            child: Hero(
                              tag: Text(postings['Seller Name']),
                              //  tag: (prod_name),
                              child: Material(
                                child: InkWell(
                                  onTap: () {},
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
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 16,
                                                      //  right: 16,
                                                      top: 4,
                                                      bottom: 4),
                                                  child: Text("Description: " +
                                                    postings['Description'],
                                                    //Text('$prod_name'),
                                                    //  Text(
                                                    //  prod_name,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  //Text(
                                                  //listings['Name'],


                                                  //style: TextStyle(
                                                  //    fontWeight:
                                                  //  FontWeight.bold),

                                                ),
                                               /* Padding(
                                                  padding: const EdgeInsets
                                                      .only(
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
                                                    postings['Description'],
                                                    //"\$prod_price",
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight
                                                          .w800,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),*/
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
                                              Text("by " +
                                                postings['Seller Name'],
                                                //'prod_shopname',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            //  ),
                                            TextButton(
                                              child: Text("  Add comment"),
                                              onPressed:()=>
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return Comments(
                                                      postId: postings['postId'],
                                                      // we need to change the post id automatically later on
                                                      // for testing only
                                                    );
                                                  })

                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                      child: Image.network(
                                          'https://googleflutter.com/sample_image.jpg'),
                                      //listings['Image URL'])])
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

