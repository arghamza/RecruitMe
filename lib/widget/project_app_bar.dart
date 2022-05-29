import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar projectAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    actions: [
      Container(
        child: const Icon(
          FontAwesomeIcons.bell,
          color: Color(0xff35ddaa),
        ),
        padding: const EdgeInsets.only(right: 12.0),
      )
    ],
    leading: const Icon(
      Icons.person,
      color: Color(0xff35ddaa),
    ),
    title: Center(
      child: Container(
        child: Image.asset('images/logofondblanccropped.png', fit: BoxFit.fill),
        padding: const EdgeInsets.only(top: 8.0),
      ),
    ),
  );
}
