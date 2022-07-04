import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/home.dart';

class Categories extends StatelessWidget {
  var currentCategory;

  Categories({this.currentCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Wrap(
          children: [
            CategoryButton(
              text: 'Popular',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Bags & Wallets',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Women\'s Clothes',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Men\'s Clothes',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Food & Beverage',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Accessories',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Toys & Games',
              currentCategory: currentCategory,
            ),
            CategoryButton(
              text: 'Others',
              currentCategory: currentCategory,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  var currentCategory;
  var text;

  CategoryButton({this.text, this.currentCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => HomeScreen(currentCategory: text,sort: 'Default')));
          },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
          color: text == currentCategory ? Colors.amber : Colors.orange,
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              text == 'Others' ? '   Others   ': text == 'Popular'? '  Popular  ': '$text',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}