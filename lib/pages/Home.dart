import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:unishare/models/User.dart';

import 'package:unishare/pages/ActivityFeed.dart';
import 'package:unishare/pages/CreateAccount.dart';
import 'package:unishare/pages/Profile.dart';
import 'package:unishare/pages/Search.dart';
import 'package:unishare/pages/Timescale.dart';
import 'package:unishare/pages/Upload.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: index);
    //detects when user signs in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleLogIn(account);
    }, onError: (err) {
      print('sign in failed: $err');
    });
    //re-authenticate user when app is opened
    googleSignIn.signInSilently().then((account) {
      handleLogIn(account);
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //function to handle sign in and change isAuth state
  handleLogIn(GoogleSignInAccount account) async {
    if (account != null) {
      await createUserInFirebase(account);
      print(account);
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirebase(GoogleSignInAccount account) async {
    //1) check if user exists in firebase
    //2) if user doesnt exist, take them to create account page
    //3) get username from create account and use it to create a doc in firebase
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.doc(user.id).get();
    if (!doc.exists) {
      final username = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CreateAccount()));
      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
      });
      doc = await usersRef.doc(user.id).get();
    }

    currentUser = User.fromDocument(doc);
    print('current user: $currentUser');
    print('current user username: ${currentUser.username}');
  }

  //sign out our users
  signOut() {
    googleSignIn.signOut();
  }

  bool isAuth = false;

  login() {
    googleSignIn.signIn();
  }

  //function to change index of page
  onPageChanged(int index) {
    setState(() {
      this.index = index;
    });
  }

  //function to change page when bottom nav bar is tapped
  onTap(int index) {
    pageController.animateToPage(index,
        curve: Curves.easeInOut, duration: Duration(milliseconds: 200));
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.add_ic_call_sharp,
      //         color: Theme.of(context).accentColor,
      //       ),
      //       onPressed: () {
      //         print('call');
      //       },
      //     )
      //   ],
      //   title: Text('UniShare'),
      // ),
      body: PageView(
        children: [
          Timescale(),
          ActivityFeed(),
          Upload(currentUser: currentUser),
          Search(),
          Profile()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: index,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor,
              ]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'UniShare',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/google_signin_button.png'),
                  fit: BoxFit.cover,
                )),
              ),
              onTap: () {
                login();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
