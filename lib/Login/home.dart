// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_type_screen/constants.dart';

import '../API/linkedin.dart';
import 'choice_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColorTheme,
      body: Container(
          color: const Color(0xff35ddaa),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, right: 25.0, left: 25.0),
                    child: Image.asset(
                      "images/logofondvert.png",
                      fit: BoxFit.contain,
                      height: 100,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                    child: SvgPicture.asset(
                      "images/HomePage.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => login()));
                        },
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Color(0xff35ddaa),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Connexion avec Email",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Color(0xff35ddaa),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "images/logogoogle.png",
                                    fit: BoxFit.contain,
                                  )),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Connexion avec Google",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Color(0xff35ddaa),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      LinkedInProfileExamplePage(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ChoiceScreen())); // Once signed in, return the UserCredentialNavigator.push(context,
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
