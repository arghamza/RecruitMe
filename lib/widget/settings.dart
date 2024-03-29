// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Login/login_screen.dart';

class SettingsNavBar extends StatefulWidget {
  const SettingsNavBar({Key? key}) : super(key: key);

  @override
  State<SettingsNavBar> createState() => _SettingsNavBarState();
}

class _SettingsNavBarState extends State<SettingsNavBar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  child: Icon(FontAwesomeIcons.user),
                  margin: EdgeInsets.only(right: 8.0),
                ),
                Flexible(
                  child: Text(
                    'Compte et confidentialité',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 18),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: const Color(0xff35ddaa),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.lock),
                Text(
                  '  Sécurité',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 18),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: const Color(0xff35ddaa),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.bell),
                Text(
                  '  Notifications',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 18),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: const Color(0xff35ddaa),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                logout(context);
              },
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.rightFromBracket),
                  Text(
                    '  Logout',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 18),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
              color: const Color(0xff35ddaa),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => login()));
  }
}
