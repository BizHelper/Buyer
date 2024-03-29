import 'package:buyer_app/src/screens/sellerlistingpage.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:buyer_app/src/screens/video.dart';
import 'package:buyer_app/src/widgets/navigateBar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final auth = AuthService().auth;
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
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
        title: const Text(
          'Explore',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('Time', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: snapshot.data!.docs.map(
                    (posts) {
                      return Center(
                        child: Card(
                          child: Hero(
                            tag: Text(posts['Seller Name']),
                            child: Material(
                              child: InkWell(
                                onTap: () {},
                                child: GridTile(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          child: Image.network(
                                              posts['Thumbnail'])),
                                      Divider(thickness: 1.5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    posts['Title'],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          right: 16,
                                                          top: 4,
                                                          bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'by ' +
                                                            posts[
                                                                'Seller Name'],
                                                        style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        child: const Text(
                                                          //'by: ${widget.productDetailShopName}',
                                                          '     Visit Shop',
                                                          style: TextStyle(
                                                              //  fontSize: 15,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => SellerListingPageScreen(
                                                                  currentCategory:
                                                                      'Popular',
                                                                  sort:
                                                                      'Default',
                                                                  sellerName: posts[
                                                                      'Seller Name'])));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, bottom: 16.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoScreen(
                                                      postID: posts['Post ID'],
                                                      videoURL: posts['URL'],
                                                      description:
                                                          posts['Description'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.info,
                                                    size: 28,
                                                    color: Colors.brown.shade500,
                                                  ),
                                                  Text(
                                                    'Find out more!',
                                                    key: Key(
                                                        "findOutMoreButton"),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.brown.shade800),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
              NavigateBar(),
            ],
          );
        },
      ),
    );
  }
}
