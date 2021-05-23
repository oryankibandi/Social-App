import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:unishare/widgets/Header.dart';
import 'package:unishare/widgets/progress.dart';

//initialized usersRef as the colection
final usersRef = FirebaseFirestore.instance.collection('users');

class Timescale extends StatefulWidget {
  @override
  _TimescaleState createState() => _TimescaleState();
}

@override
class _TimescaleState extends State<Timescale> {
  void initState() {
    super.initState();
    getUsers();
    // getUserById();
    print('done');
  }

//function to get users from users collection and print
  Future getUsers() async {
    QuerySnapshot querysnapshot = await usersRef
        .where("isAdmin", isEqualTo: false)
        .where("username", isEqualTo: "ben")
        .get();
    querysnapshot.docs.forEach((doc) {
      print(doc.data());
    });
  }

  //Function to get users by id
  getUserById() async {
    String id = 'WpuHnJ6bppHD9zU0HwyD';
    DocumentSnapshot doc = await usersRef.doc(id).get();
    print(doc.data());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Unishare', 50.0, 'Signatra'),
      body: Center(
        child: circularProgress(),
      ),
    );
  }
}
