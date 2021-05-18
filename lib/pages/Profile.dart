import 'package:flutter/material.dart';
import 'package:unishare/widgets/Header.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'profile', 22.0, ''),
    );
  }
}
