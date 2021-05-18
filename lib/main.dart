import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unishare/pages/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, accentColor: Colors.teal),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
