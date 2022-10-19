import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
        color: Colors
            .black), 
    leading: BackButton(
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
