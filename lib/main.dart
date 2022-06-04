import 'package:buyer_app/src/app.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
//runApp(MultiProvider(providers:
  //  [ChangeNotifierProvider(create: (BuildContext context) { TestNotifier(); },)],
 // child: App()));
}
