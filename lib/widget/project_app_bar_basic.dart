import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_type_screen/model/user_model.dart';

import '../Login/login_screen.dart';

AppBar projectAppBarBasic(BuildContext context) {
  return AppBar(
    elevation: 0,
    leading: Container(
      margin: const EdgeInsets.only(top: 8.0),
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
    toolbarHeight: MediaQuery.of(context).size.height * 0.10,
  );
}

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => const login()));
}
