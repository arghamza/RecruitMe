// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantHome extends StatefulWidget {
  const ApplicantHome({Key? key}) : super(key: key);

  @override
  State<ApplicantHome> createState() => _ApplicantHomeState();
}

class _ApplicantHomeState extends State<ApplicantHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: width - 40,
            height: height - 240,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 190, 244, 227),
                borderRadius: BorderRadius.circular(60)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                  child: Text(
                    'Titre de l\'offre',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 30),
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
                            fontSize: 20),
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'Google',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 18),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Poste:   ',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20),
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'Stagiaire',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 18),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Domaine:   ',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20),
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'Informatique',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 18),
                        fontWeight: FontWeight.w300),
                  ),
                ])),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'A propos de l\'offre:',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 20),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: width - 110,
                  height: height - 550,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 18),
                          fontWeight: FontWeight.w300),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 660, left: 25),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80), color: Colors.red),
                child: Icon(
                  FontAwesomeIcons.xmark,
                  size: 40,
                ),
              ),
              SizedBox(
                width: 65,
              ),
              CircleAvatar(
                backgroundImage: AssetImage("images/avatar.png"),
                radius: 50,
              ),
              SizedBox(
                width: 65,
              ),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: const Color(0xff35ddaa),
                ),
                child: Icon(
                  FontAwesomeIcons.suitcase,
                  size: 40,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
