// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Recruiter/creationoffre_screen.dart';
import 'package:user_type_screen/Recruiter/recruiter_main_screen.dart';

import '../constants.dart';
import '../model/offre_model.dart';

class RecruiterHome extends StatefulWidget {
  const RecruiterHome({Key? key}) : super(key: key);

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {
  List<OffreModel> offers = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  void initState() {
    FirebaseAuth user = FirebaseAuth.instance;
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      firebaseFirestore
          .collection("users")
          .doc(user.currentUser?.uid)
          .get()
          .then((value) {
        for (var element in List.from(value.data()!['offres'])) {
          OffreModel model = OffreModel.fromMap(element);
          setState(() {
            offers.add(model);
          });
        }
        setState(() {});
      });
    });
  }

  int currentindextap = 0;
  void onTap(int index) {
    setState(() {
      currentindextap = index;
    });
  }

  List pages = [
    RecruiterHome(),
    Text(
      "Chat",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(OffreModel offer) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Container(
            height: 30,
            margin: EdgeInsets.all(10),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
              Icon(Icons.edit, size: 25, color: Colors.black),
              Icon(Icons.delete, size: 25, color: Colors.black),
            ]),
          ),
          subtitle: Container(
            margin: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 30),
                  child: Text(
                    '${offer.titre}',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 25),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Entreprise:   ',
                    style: kFormsTextFont,
                  ),
                  TextSpan(
                    text: '${offer.entreprise}',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 12,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Poste:   ',
                    style: kFormsTextFont,
                  ),
                  TextSpan(
                    text: '${offer.poste}',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 12,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Domaine:   ',
                    style: kFormsTextFont,
                  ),
                  TextSpan(
                    text: '${offer.domaine}',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'A propos de l\'offre:',
                  style: kFormsTextFont,
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  width: 200,
                  height: 230,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${offer.details}',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 10),
                          fontWeight: FontWeight.w300),
                    ),
                  )),
                ),
              ],
            ),
          ),
        );

    Card makeCard(OffreModel offer) => Card(
          elevation: 10.0,
          color: Color.fromARGB(255, 190, 244, 227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: makeListTile(offer),
        );
    final OffersList = SizedBox(
      height: 900,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: offers.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 75, top: 50, bottom: 30),
                      alignment: Alignment.topCenter,
                      child: Text(" Mes offres   ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )),
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreationOffre()));
                      }),
                      child: Container(
                        margin: EdgeInsets.only(left: 50, top: 50, bottom: 30),
                        child: Icon(
                          Icons.add_comment_outlined,
                          color: const Color(0xff35ddaa),
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecruiterMainScreen(
                                offerId: offers[index].offerId ?? "",
                              )));
                    },
                    child: makeCard(offers[index])),
              ],
            );
          } else {
            return GestureDetector(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecruiterMainScreen(
                              offerId: offers[index].offerId,
                            )));
                  });
                },
                child: makeCard(offers[index]));
          }
        },
      ),
    );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          height: 900,
          alignment: Alignment.bottomCenter,
          child: OffersList,
        ));
  }

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
