/*
import 'dart:ffi';
import 'dart:io';
import 'package:buyer_app/src/screens/post2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AuthService.dart';


class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}



class _PostScreenState extends State<PostScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //String url= '';
  late var url = '';
  String _fullName = '';
  late File _pickedImage;
  late String profileVideo = '';

 /* void _method() async {
    //need change the file name to this???
    //final ref = FirebaseStorage.instance.ref().child('buyersimages').child(_fullName + '.jpg');
    // await ref.putFile(_pickedImage);
    final uid = AuthService().currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('buyers').
    doc(uid).get();
    //String buyerName = ds.get('Name');
    profileVideo = ds.get('imageUrl');
    await FirebaseFirestore.instance.collection('buyers').doc(uid).set({
      'id': uid,
      'imageUrl': url
    });
  }

  */
  void _method() async {
    final uid = AuthService().currentUser?.uid;
    DocumentReference dr = FirebaseFirestore.instance.collection('postings').doc();
    dr.set({
      'id': dr.id,
      'imageUrl': url

    });
  }


  @override
  Widget build(BuildContext context) {
    _method();
    Future selectFile() async {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() {
        pickedFile = result.files.first;
      }
      );
    }

    Future uploadFile() async {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });
      ref.putFile(file);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Download Link: $urlDownload');


      setState(() {
        url = urlDownload;
        uploadTask = null;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Post1(profileVideo: urlDownload)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Play Video from Assets/URL"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: selectFile,
                  child: const Text('Select File')),
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: uploadFile,
                  child: const Text('Upload File')),
              const SizedBox(height: 32),
            ],
          ),
        )

    );
  }
}*/
