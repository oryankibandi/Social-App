import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unishare/models/User.dart';
import 'package:unishare/pages/Timescale.dart';
import 'package:unishare/widgets/progress.dart';
import 'package:unishare/widgets/userResult.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  Future<QuerySnapshot> matchingUsers;
  Future<QuerySnapshot> noMatchingUsers;
  clearText() {
    textEditingController.clear();
    setState(() {
      matchingUsers = noMatchingUsers;
    });
  }

  searchUser(String user) {
    Future users = usersRef
        .where(
          'username',
          isEqualTo: user,
        )
        .get();
    setState(() {
      matchingUsers = users;
    });
  }

  AppBar buildSearchBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
          prefixIcon: Icon(Icons.account_box_rounded),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => clearText(),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        onChanged: (value) {
          if (value.trim().isNotEmpty) {
            searchUser(value);
          }
        },
        onFieldSubmitted: (value) {
          if (value.isEmpty) {
            return null;
          }
          searchUser(value);
        },
        onSaved: (value) {
          if (value.isEmpty) {
            return null;
          }
          searchUser(value);
        },
        onEditingComplete: () {},
      ),
    );
  }

  buildSearchScreen() {
    return FutureBuilder(
      future: matchingUsers,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> usersList = [];
        snapshot.data.docs.forEach((doc) {
          User user = User.fromDocument(doc);
          usersList.add(UserResult(
            user: user,
          ));
        });

        return ListView(
          children: usersList,
        );
      },
    );
  }

  buildNoSearchScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      alignment: Alignment.center,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 300.0 : 150,
            ),
            Text(
              'Find Users',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 50.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchBar(),
      body: matchingUsers == null ? buildNoSearchScreen() : buildSearchScreen(),
    );
  }
}
