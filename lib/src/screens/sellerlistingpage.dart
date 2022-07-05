import 'package:buyer_app/src/screens/chatscreen.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:buyer_app/src/widgets/categories.dart';
import 'package:buyer_app/src/widgets/navigateBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/login.dart';
import '../widgets/products.dart';

class SellerListingPageScreen extends StatefulWidget {
  var currentCategory;
  var sort;
  //var sellerId;
  var sellerName;
  // HomeScreen({Key? key, required this.currentCategory, required this.sort}) : super(key: key);

  SellerListingPageScreen({required this.currentCategory, required this.sort,
    //this.sellerId,
  this.sellerName});
  @override
  State<SellerListingPageScreen> createState() => _SellerListingPageScreenState();
}

class _SellerListingPageScreenState extends State<SellerListingPageScreen> {
  final FirebaseAuth _auth = AuthService().auth;

  final db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  List allResults = [];
  List filteredResults = [];
  late Future resultsLoaded;
  final List<String> sortCategories = [
    'Default',
    'Price: high to low',
    'Price: low to high',
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  getListingList() async {
    var data = widget.currentCategory == 'Popular'?
    FirebaseFirestore.instance
        .collection('listings').
    //where('Seller Id', isEqualTo: widget.sellerName)
    where('Seller Name', isEqualTo: widget.sellerName)
        .where('Deleted', isEqualTo: 'false'):
    FirebaseFirestore.instance
        .collection('listings').
    //where('Seller Id', isEqualTo: widget.sellerName)
    where('Seller Name', isEqualTo: widget.sellerName)
        .where('Deleted', isEqualTo: 'false').where('Category', isEqualTo: widget.currentCategory);
    var sortedData = widget.sort == 'Price: high to low'
        ? await data.orderBy('Price Double', descending: true).get()
        : widget.sort == 'Price: low to high'
        ? await data.orderBy('Price Double').get()
        : await data.get();
    setState(()=> allResults = sortedData.docs);
    searchResultList();
    return sortedData.docs;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getListingList();
  }

  onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (searchController.text != '') {
      for (var listings in allResults) {
        var title = listings['Name'].toString().toLowerCase();

        if (title.contains(searchController.text.toLowerCase())) {
          showResults.add(listings);
        }
      }
    } else {
      showResults = List.from(allResults);
    }
    setState(() => filteredResults = showResults);
  }


  /* stream:
  currentCategory == 'Popular'?
  FirebaseFirestore.instance
      .collection('listings')
      .where('Deleted', isEqualTo: 'false')
      .snapshots():
        FirebaseFirestore.instance
      .collection('listings')
      .where('Deleted', isEqualTo: 'false').where('Category', isEqualTo: currentCategory)
      .snapshots(),

  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
        //  IconButton(onPressed: () {
          //}, icon: Icon(Icons.search)),
         /* IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              icon: Icon(Icons.chat)),

          */
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
          'Seller Listing Page',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /*const Padding(
                padding: EdgeInsets.only(left: 12, top: 11),
                child:
                Text(
                  'Categories',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

               */
            /*  Padding(
                padding: EdgeInsets.only(right: 11.0, top: 12),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: const Text(
                    'Favourites',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
             */
            ],
          ),
        // Categories(currentCategory: widget.currentCategory),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0,),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Listings',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField(
                value: widget.sort,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.sort),
                ),
                items: sortCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text('$category'),
                  );
                }).toList(),
                onChanged: (val) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SellerListingPageScreen(
                        currentCategory: widget.currentCategory,
                        sort: val,
                        //sellerId:widget.sellerId
                        sellerName: widget.sellerName,
                      ),
                    ),
                  );
                }
            ),
          ),
          Flexible(
            child: Container(
              child:
              /* GridView.count(

                    crossAxisCount: 2,
                    children: snapshot.data!.docs.map(
                      (listings) {
                        return Product(
                          prodName: listings['Name'],
                          prodShopName: listings['Seller Name'],
                          prodPrice: listings['Price'],
                          prodCategory: listings['Category'],
                          prodDescription: listings['Description'],
                          prodImage: listings['Image URL'],
                          sellerId: listings['Seller Id'],
                          listingId: listings['Listing ID'],
                          deleted: listings['Deleted'],
                        );
                      },
                    ).toList(),
                  ),*/
              GridView.builder( gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: filteredResults.length,
                itemBuilder: (BuildContext context,int index)=>
                    Product(
                      prodName: filteredResults[index]['Name'],
                      prodShopName: filteredResults[index]['Seller Name'],
                      prodPrice: filteredResults[index]['Price'],
                      prodCategory: filteredResults[index]['Category'],
                      prodDescription: filteredResults[index]['Description'],
                      prodImage: filteredResults[index]['Image URL'],
                      sellerId: filteredResults[index]['Seller Id'],
                      listingId: filteredResults[index]['Listing ID'],
                      deleted: filteredResults[index]['Deleted'],
                    ),
              ),
            ),
          ),
          NavigateBar(),
        ],
      ),
    );
  }
}
