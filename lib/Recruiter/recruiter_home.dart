// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Recruiter/creationoffre_screen.dart';

import '../model/offre_model.dart';

class RecruiterHome extends StatefulWidget {
  const RecruiterHome({Key? key}) : super(key: key);

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {
  List<OffreModel> offers = [];
  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
          print("heeeeeeeey :    " '${model.entreprise}');
          setState(() {
            offers.add(model);
          });
          print(" length : " '${offers.length}');
        }
        setState(() {});
      });
      setState(() {
        // Here you can write your code for open new view
      });
    });
    firebaseFirestore
        .collection("users")
        .doc(user.currentUser?.uid)
        .get()
        .then((value) {
      for (var element in List.from(value.data()!['offres'])) {
        OffreModel model = OffreModel.fromMap(element);
        print("heeeeeeeey :    " '${model.entreprise}');
        setState(() {
          offers.add(model);
        });
        print(" length : " '${offers.length}');
      }
      setState(() {});
    });
    print(" length : " '${offers.length}');
  }

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
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                        fontWeight: FontWeight.w600),
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
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: '${offer.poste}',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 12),
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
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: '${offer.domaine}',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 12),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'A propos de l\'offre:',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 15),
                      fontWeight: FontWeight.w600),
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
                              fontSize: 15),
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
          margin: new EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: makeListTile(offer),
        );
    final OffersList = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: offers.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(offers[index]);
        },
      ),
    );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
            height: 700,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.topCenter,
                    child: Text(" Mes offres   ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    height: 550,
                    alignment: Alignment.bottomCenter,
                    child: OffersList,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreationOffre()));
                    }),
                    child: Container(
                      margin: EdgeInsets.only(top: 100, left: 340),
                      child: Icon(
                        Icons.add_comment_outlined,
                        color: const Color(0xff35ddaa),
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
