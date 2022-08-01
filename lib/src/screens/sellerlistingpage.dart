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
  String sellerName;

  SellerListingPageScreen(
      {required this.currentCategory,
      required this.sort,
      required this.sellerName});
  @override
  State<SellerListingPageScreen> createState() =>
      _SellerListingPageScreenState();
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
    var data = widget.currentCategory == 'Popular'
        ? FirebaseFirestore.instance
            .collection('listings')
            .
            //where('Seller Id', isEqualTo: widget.sellerName)
            where('Seller Name', isEqualTo: widget.sellerName)
            .where('Deleted', isEqualTo: 'false')
        : FirebaseFirestore.instance
            .collection('listings')
            .
            //where('Seller Id', isEqualTo: widget.sellerName)
            where('Seller Name', isEqualTo: widget.sellerName)
            .where('Deleted', isEqualTo: 'false')
            .where('Category', isEqualTo: widget.currentCategory);
    var sortedData = widget.sort == 'Price: high to low'
        ? await data.orderBy('Price Double', descending: true).get()
        : widget.sort == 'Price: low to high'
            ? await data.orderBy('Price Double').get()
            : await data.get();
    setState(() => allResults = sortedData.docs);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        actions: <Widget>[
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
          'Seller Shop',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
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
                }),
          ),
          Flexible(
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: filteredResults.length,
                itemBuilder: (BuildContext context, int index) => Product(
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
        ],
      ),
    );
  }
}
