import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/model/user_model.dart';
import 'package:user_type_screen/widget/delete_dialog.dart';

import 'admin_screen.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  List<UserModel> users = [];
  bool _isShown = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                "Users",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black, letterSpacing: .5, fontSize: 20),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: Column(
                          children: [
                            ExpandablePanel(
                              header: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'User:   ',
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: 17),
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: users[index].FirstName! +
                                      " " +
                                      users[index].SecondName!,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: 15),
                                      fontWeight: FontWeight.w300),
                                ),
                              ])),
                              collapsed: Container(),
                              expanded: Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: Center(
                                          child: Column(
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Email:   ',
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff35ddaa),
                                                      letterSpacing: .5,
                                                      fontSize: 15),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            TextSpan(
                                              text: users[index].email,
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      letterSpacing: .5,
                                                      fontSize: 13),
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ])),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text: 'UID:   ',
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff35ddaa),
                                                      letterSpacing: .5,
                                                      fontSize: 15),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            TextSpan(
                                              text: users[index].uid,
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      letterSpacing: .5,
                                                      fontSize: 13),
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ])),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )),
                                    ),
                                    TextButton(
                                        onPressed: _isShown == true
                                            ? () => {
                                                  setState(() {
                                                    _isShown = false;
                                                  }),
                                                  deleteWidget(
                                                      context,
                                                      users[index].uid!,
                                                      "users",
                                                      const AdminScreen(),
                                                      'Vous êtes sûr de vouloir effacer cette utilisateur?',
                                                      _isShown)
                                                }
                                            : null,
                                        child: const Icon(
                                          FontAwesomeIcons.trashCan,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    // Get docs from collection reference
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("users").get().then((value) {
      for (var element in List.from(value.docs)) {
        UserModel model = UserModel.fromMap(element);
        setState(() {
          users.add(model);
        });
      }
    });
  }
}
