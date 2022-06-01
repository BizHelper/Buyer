import 'package:buyer_app/src/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../UserData.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({Key? key}) : super(key: key);

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  late String _name ;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   // final user = Provider.of<AppUser>(context);
   // final user = Provider;
    final user= Provider.of<AppUser> (context);
    return Scaffold(

    backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        title: const Text(
          'Update Screen',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),

        child:
        StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData userData = snapshot.data!;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text('Update your buyers setting',
                        style: TextStyle(fontSize: 18.0),),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: InputDecoration(fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink, width: 2.0))),
                        //validator: (val)=> val.isEmpty? 'Please enter a name': null,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                        onChanged: (val) => setState(() => _name = val),),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        child: Text('Update', style: TextStyle(color: Colors
                            .white),),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: userData.uid)
                                .updateUserData(
                                _name ?? userData.name
                            );
                            Navigator.pop(context);
                          }
                          print(_name);
                        },)
                    ],
                  ),
                );
              }
              else {
                return Container();
                /*
              return Container(
                color: Colors.brown[100],
                child: Center(
                  child: SpinKitChasingDots(

                  ),
                ),
              )

               */
                // write
              }
            }
        ),
      ),
    );
  }
}


