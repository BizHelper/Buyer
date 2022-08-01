import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerDescriptionScreen extends StatefulWidget {
  String profilePicUrl;
  String name;
  String address;
  String description;

  SellerDescriptionScreen(
      {required this.profilePicUrl,
      required this.name,
      required this.description,
      required this.address});

  @override
  State<SellerDescriptionScreen> createState() =>
      _SellerDescriptionScreenState();
}

class _SellerDescriptionScreenState extends State<SellerDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        title: const Text(
          'Shop Description',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.profilePicUrl),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Address: " + widget.address,
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20.0),
                  Text("Description: " + widget.description,
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
