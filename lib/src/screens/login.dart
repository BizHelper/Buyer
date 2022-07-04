import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/reset.dart';
import 'package:buyer_app/src/screens/signup.dart';
import 'package:buyer_app/src/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _email;
  var _password;
  final auth = AuthService().auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade900,
        centerTitle: true,
        title: const Text(
          'BizHelper',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Icon(
              Icons.store_rounded,
              size: 120,
              color: Colors.black,
            ),
             Text(
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                'Buyer Login'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  setState(
                    () {
                      _email = value.trim();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(
                    () {
                      _password = value.trim();
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange.shade600)),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    String? result =
                        await Auth(auth: auth).signin(_email, _password);
                    if (result == 'Success') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen(currentCategory: "Popular",sort: 'Default')));
                    } else {
                      Fluttertoast.showToast(
                          msg: result ?? '', gravity: ToastGravity.TOP);
                    }
                  },
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange.shade600)),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SignupScreen())),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Forgot Password?'),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetScreen())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  signin(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(currentCategory: "Popular",sort: 'Default')));
      return "Success";
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
    }
  }
}
