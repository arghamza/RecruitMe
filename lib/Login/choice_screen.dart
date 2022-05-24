// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Demandeur/add_info_screen.dart';

import '../Recruiter/Info_screen.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Image.asset('images/logofondblanccropped.png',
                    fit: BoxFit.fill),
                margin: const EdgeInsets.only(left: 65, top: 10.0),
                width: 170,
              )
            ],
          ),
          elevation: 0,
        ),

        //-----------------------------------body
        body: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  'ETES-VOUS ',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 20),
                      fontWeight: FontWeight.w600),
                ),
                margin: const EdgeInsets.only(top: 30),
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 40, left: 30),
                    child: SvgPicture.asset(
                      'images/recruiter.svg',
                      width: 400,
                      height: 230,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 100,
                    child: Container(
                      width: 200,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Info_screen()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(53, 221, 170, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 15.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Recruteur',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 25),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                child: Text(
                  'OU',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 20),
                      fontWeight: FontWeight.w600),
                ),
                margin: const EdgeInsets.only(top: 50),
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(top: 30, right: 0),
                    child: SvgPicture.asset(
                      'images/applicant.svg',
                      width: 250,
                      height: 260,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 90,
                    child: Container(
                      width: 200,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApplicantScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(53, 221, 170, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 15.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Demandeur',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 25),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
