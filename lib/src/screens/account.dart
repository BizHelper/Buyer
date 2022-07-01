import 'dart:io';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:buyer_app/src/widgets/navigateBar.dart';
import 'package:provider/provider.dart';

import '../providers/LocationProvider.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth auth = AuthService().auth;
  String _buyerName = '';
  var _image = '';

  Future<String> getBuyerName() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    setState(() => _buyerName = ds.get('Name'));
    return _buyerName;
  }

  String getName() {
    getBuyerName();
    return _buyerName;
  }

  Future<String> getImageFile() async {
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('buyers').doc(uid).get();
    setState(
      () {
        if ((ds.data() as Map<String, dynamic>).containsKey('Profile Pic')) {
          _image = ds.get('Profile Pic');
        }
      },
    );
    return _image;
  }

  String getImage() {
    getImageFile();
    return _image;
  }

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
          'Account',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.network(getImage()).image,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
               // AuthService().getName()
                getName(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[600])),
                      onPressed: () async {
                        final uid = AuthService().currentUser?.uid;
                        String sellerName = getName();
                        DocumentReference dr = FirebaseFirestore.instance
                            .collection('buyers')
                            .doc(uid);
                        final XFile? pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile == null) {
                          print('null');
                          return;
                        }
                        final File image = (File(pickedFile.path));

                        FirebaseStorage storage = FirebaseStorage.instance;
                        Reference ref = storage
                            .ref()
                            .child(pickedFile.path + DateTime.now().toString());
                        await ref.putFile(image);
                        String imageURL = await ref.getDownloadURL();
                        dr.set({'Name': sellerName, 'Profile Pic': imageURL});
                        setState(() => _image = imageURL);
                      },
                         child: const Text(
                        'Change Profile Picture',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          NavigateBar(),
        ],
      ),
    );
  }
}
