import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerDescriptionScreen extends StatefulWidget {
  String profilePicUrl;
  String name;

  SellerDescriptionScreen({required this.profilePicUrl,  required this.name});


  @override
  State<SellerDescriptionScreen> createState() => _SellerDescriptionScreenState();
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
        body: Column(children: [
          Image.network(widget.profilePicUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.name),
          )],));
  }
}
