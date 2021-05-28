import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AppBar buildSearchBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: TextFormField(
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
            onPressed: () => print('cleared'),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }

  buildNoSearchScreen() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              'assets/images/search.svg',
              height: 300.0,
            ),
            Text(
              'Find Users',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 60.0),
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
      body: buildNoSearchScreen(),
    );
  }
}
