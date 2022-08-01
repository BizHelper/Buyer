import 'package:buyer_app/src/screens/login.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
     // routes: {MapScreen.id : (context)=> MapScreen()},
      home: LoginScreen(),
    );
  }
}
