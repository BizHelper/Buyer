import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Leather Wallet",
      "picture": "images/wallet.jpg",
      "shop_name": "Wallet Shop",
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "images/dress.jpg",
      "shop_name": "The Dress Shop",
      "price": 100,
    },
    {
      "name": "Blue Bag",
      "picture": "images/bag.jpg",
      "shop_name": "The Bag Shop",
      "price": 200,
    },
    {
      "name": "Blouse",
      "picture": "images/clothes.jpg",
      "shop_name": "The Clothing",
      "price": 50,
    },
    {
      "name": "Crochet Shirt",
      "picture": "images/crochet1.jpg",
      "shop_name": "Crochet With Love",
      "price": 70,
    },
    {
      "name": "Crochet earrings",
      "picture": "images/crochetearrings.jpg",
      "shop_name": "The Earring Shop",
      "price": 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Single_prod(
          prod_name: product_list[index]['name'],
          prod_picture: product_list[index]['picture'],
          prod_shop_name: product_list[index]['shop_name'],
          prod_price: product_list[index]['price'],
        );
      },
    );
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_shop_name;
  final prod_price;

  Single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_shop_name,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 4),
                          child: Text(
                            '$prod_name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 4),
                          child: Text(
                            "\$$prod_price",
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
                        '$prod_shop_name',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
