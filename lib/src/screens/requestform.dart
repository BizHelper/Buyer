import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/authservice.dart';

class RequestFormScreen extends StatefulWidget {
  const RequestFormScreen({Key? key}) : super(key: key);

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}


class _RequestFormScreenState extends State<RequestFormScreen> {
  final FirebaseAuth _auth = AuthService().auth;
  final _formKey = GlobalKey<FormState>();
  final List<String> categories = [
    'Bags & Wallets',
    'Women\'s Clothes',
    'Men\'s Clothes',
    'Food & Beverage',
    'Accessories',
    'Toys & Games',
    'Others'
  ];

  PlatformFile? pickedImageFile;
  UploadTask? uploadTaskImage;
  final db = FirebaseFirestore.instance;

  late String _buyerName;
  late String _currentTitle;
  late String _currentDeadline;
  late String _currentPrice;
  late String _currentCategory;
  late String _currentDescription;
  bool dateSelected = false;

  showAlertDialog(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text(
        'Deadline not selected',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
        title: const Text(
          'Add Request',
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'New Request',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade600,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a title' : null,
                  onChanged: (val) => setState(() => _currentTitle = val),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Price',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade600,
                        width: 2.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))
                  ],
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a price' : null,
                  onChanged: (val) => setState(() =>
                      _currentPrice = double.parse(val).toStringAsFixed(2)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'Category',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade600,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (val) =>
                      val == null ? 'Please select category' : null,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text('$category'),
                    );
                  }).toList(),
                  onChanged: (val) =>
                      setState(() => _currentCategory = val.toString()),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade600,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a description' : null,
                  onChanged: (val) => setState(() => _currentDescription = val),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[600])),
                      onPressed: () async {
                        DateTime? date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2023),
                        );
                        if (date != null) {
                          setState(() {
                            _currentDeadline =
                                '${date?.day.toString()}/${date?.month.toString()}/${date?.year.toString()}';
                            dateSelected = true;
                          });
                        }
                      },
                      child: const Text(
                        'Select Deadline',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    dateSelected
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.orange[600])),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final uid = AuthService().currentUser?.uid;
                                DocumentSnapshot ds = await FirebaseFirestore
                                    .instance
                                    .collection('buyers')
                                    .doc(uid)
                                    .get(); // change to buyers
                                _buyerName = ds.get('Name');
                                DocumentReference dr = FirebaseFirestore
                                    .instance
                                    .collection('requests')
                                    .doc();
                                Map<String, Object> request = new HashMap();
                                request.putIfAbsent(
                                    'Buyer Name', () => _buyerName);
                                request.putIfAbsent(
                                    'Category', () => _currentCategory);
                                request.putIfAbsent(
                                    'Deadline', () => _currentDeadline);
                                request.putIfAbsent(
                                    'Description', () => _currentDescription);
                                request.putIfAbsent(
                                    'Price', () => _currentPrice);
                                request.putIfAbsent('Request ID', () => dr.id);
                                request.putIfAbsent(
                                    'Seller Name', () => 'null');
                                request.putIfAbsent(
                                    'Title', () => _currentTitle);
                                request.putIfAbsent('Accepted', () => 'false');
                                request.putIfAbsent(
                                    'Buyer ID', () => _auth.currentUser!.uid);
                                request.putIfAbsent('Price Double', () => double.parse(_currentPrice));
                                request.putIfAbsent('Deleted', () => 'false');
                                request.putIfAbsent('Time', () => DateTime.now().microsecondsSinceEpoch);
                                dr.set(request);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestFormScreen()));
                              }
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.amber[600])),
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
