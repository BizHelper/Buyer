import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';

class Product extends StatelessWidget {
  var prodName;
  var prodShopName;
  var prodPrice;
  var prodCategory;
  var prodDescription;
  var prodImage;
  var prodId;
  var sellerId;
  var listingId;
  var deleted;

  Product({
    this.prodName,
    this.prodShopName,
    this.prodPrice,
    this.prodCategory,
    this.prodDescription,
    this.prodImage,
    this.prodId,
    this.sellerId,
    this.listingId,
    required this.deleted,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Hero(
          tag: Text(prodName),
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDescriptionScreen(
                      productDetailName: prodName,
                      productDetailShopName: prodShopName,
                      productDetailPrice: prodPrice,
                      productDetailCategory: prodCategory,
                      productDetailDescription: prodDescription,
                      productDetailImages: prodImage,
                      productDetailId: prodId,
                      sellerId: sellerId,
                      listingId: listingId,
                      iconsButtons: true,
                      deleted: deleted,
                    ),
                  ),
                );
              },
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 4, bottom: 4),
                              child: Text(
                                prodName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 4, bottom: 4),
                            child: Text(
                              prodPrice,
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
                            left: 16, right: 16, top: 4, bottom: 4),
                        child: Text(
                          prodShopName,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child: (Uri.tryParse(prodImage)?.hasAbsolutePath ?? false)
                    ? Image.network(prodImage)
                    : Image.asset('images/noImage.jpg'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
