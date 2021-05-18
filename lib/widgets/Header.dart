import 'package:flutter/material.dart';

AppBar header(
    BuildContext context, String title, double fontsize, String fontStyle) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: fontStyle,
        fontSize: fontsize,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
