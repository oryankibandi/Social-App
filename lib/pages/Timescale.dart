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
    deleteUser();
    // getUsers();
    // getUserById();
    // print('done');
  }

//function to get users from users collection and print
  // Future getUsers() async {
  //   QuerySnapshot querysnapshot = await usersRef
  //       .where("isAdmin", isEqualTo: false)
  //       .where("username", isEqualTo: "ben")
  //       .get();
  //   querysnapshot.docs.forEach((doc) {
  //     print(doc.data());
  //   });
  // }

  //Function to get users by id
  // getUserById() async {
  //   String id = 'WpuHnJ6bppHD9zU0HwyD';
  //   DocumentSnapshot doc = await usersRef.doc(id).get();
  //   print(doc.data());
  // }

  createUser() {
    usersRef.doc().set({
      "username": "Alison",
      "isAdmin": false,
      "postsCount": 0,
    });
  }

  updateUser() async {
    final userSnapshot = await usersRef.doc('Uxq9V0RgcNdl9fcasHo9').get();
    if (userSnapshot.exists) {
      userSnapshot.reference.update({
        "username": "benjamin",
        "isAdmin": true,
        "postsCount": 2,
      });
    }
  }

  deleteUser() async {
    final userSnapshot = await usersRef.doc('Uxq9V0RgcNdl9fcasHo9').get();
    if (userSnapshot.exists) {
      userSnapshot.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, 'Unishare', 50.0, 'Signatra'),
        body: StreamBuilder(
          stream: usersRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            final List<ListTile> children = snapshot.data.docs
                .map<ListTile>((doc) => ListTile(
                      leading: Icon(Icons.account_circle),
                      tileColor: Colors.purple[300],
                      title: Text(
                        doc['username'],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      contentPadding: EdgeInsets.all(5.0),
                    ))
                .toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ));
  }
}
