// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../Login/choice_screen.dart';

const String redirectUrl = 'https://www.youtube.com/callback';
const String clientId = '776rnw4e4izlvg';
const String clientSecret = 'rQEgboUHMLcQi59v';

class LinkedInProfileExamplePage extends StatefulWidget {
  const LinkedInProfileExamplePage({Key? key}) : super(key: key);

  @override
  State createState() => _LinkedInProfileExamplePageState();
}

class _LinkedInProfileExamplePageState
    extends State<LinkedInProfileExamplePage> {
  UserObject user = UserObject();
  bool logoutUser = false;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "images/logolinkedin.png",
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Text("Connexion avec LinkedIn",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color(0xff35ddaa),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => LinkedInUserWidget(
                    appBar: AppBar(
                      backgroundColor: Color(0xff35ddaa),
                      title: const Text('Connexion avec LinkedIn'),
                    ),
                    destroySession: logoutUser,
                    redirectUrl: redirectUrl,
                    clientId: clientId,
                    clientSecret: clientSecret,
                    projection: const [
                      ProjectionParameters.id,
                      ProjectionParameters.localizedFirstName,
                      ProjectionParameters.localizedLastName,
                      ProjectionParameters.firstName,
                      ProjectionParameters.lastName,
                      ProjectionParameters.profilePicture,
                    ],
                    onError: (final UserFailedAction e) {
                      print('Error: ${e.toString()}');
                      print('Error: ${e.stackTrace.toString()}');
                    },
                    onGetUserProfile: (final UserSucceededAction linkedInUser) {
                      print(
                        'Access token ${linkedInUser.user.token.accessToken}',
                      );

                      print('User id: ${linkedInUser.user.userId}');

                      user = UserObject(
                        firstName:
                            linkedInUser.user.firstName?.localized?.label,
                        lastName: linkedInUser.user.lastName?.localized?.label,
                        email: linkedInUser
                            .user.email?.elements![0].handleDeep?.emailAddress,
                        profileImageUrl: linkedInUser
                            .user
                            .profilePicture
                            ?.displayImageContent
                            ?.elements![0]
                            .identifiers![0]
                            .identifier,
                      );

                      setState(() {
                        logoutUser = false;
                      });

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoiceScreen()));
                    },
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          // LinkedInButtonStandardWidget(
          //   onTap: () {
          //     setState(() {
          //       user = UserObject();
          //       logoutUser = true;
          //     });
          //   },
          //   buttonText: 'Logout',
          // ),
        ],
      ),
    );
  }
}

class AuthCodeObject {
  AuthCodeObject({this.code, this.state});

  String? code;
  String? state;
}

class UserObject {
  UserObject({
    this.firstName,
    this.lastName,
    this.email,
    this.profileImageUrl,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? profileImageUrl;
}
