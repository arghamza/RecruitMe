import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar projectAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
    actions: [
      Container(
        child: const Flexible(
          child: Icon(
            FontAwesomeIcons.bell,
            color: Color(0xff35ddaa),
          ),
        ),
        padding: const EdgeInsets.only(right: 16.0, top: 10.0),
      )
    ],
    leading: Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: const Flexible(
        child: Icon(
          Icons.person,
          color: Color(0xff35ddaa),
        ),
      ),
    ),
    title: Container(
      child: Flexible(
          child:
              Image.asset('images/logofondblanccropped.png', fit: BoxFit.fill)),
      padding: const EdgeInsets.only(top: 20.0),
    ),
  );
}
