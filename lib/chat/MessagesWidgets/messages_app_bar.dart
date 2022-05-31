import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar messagesAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xff35ddaa),
    actions: [
      Container(
        child: const Icon(
          FontAwesomeIcons.bell,
          color: Color(0xff35ddaa),
        ),
        padding: const EdgeInsets.only(right: 15.0),
      )
    ],
    leading: TextButton(
      child: const Icon(
        Icons.arrow_back_rounded,
        color: Color(0xff35ddaa),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Center(
      child: Container(
        child: Image.asset('images/logofondblanccropped.png', fit: BoxFit.fill),
        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
      ),
    ),
  );
}
