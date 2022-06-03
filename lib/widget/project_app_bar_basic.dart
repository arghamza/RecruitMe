import 'package:flutter/material.dart';

AppBar projectAppBarBasic(BuildContext context) {
  return AppBar(
    elevation: 0,
    leading: Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0xff35ddaa),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
    backgroundColor: Colors.white,
    toolbarHeight: MediaQuery.of(context).size.height * 0.08,
  );
}
