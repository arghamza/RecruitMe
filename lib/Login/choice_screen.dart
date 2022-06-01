// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Demandeur/add_info_screen.dart';
import 'package:user_type_screen/constants.dart';

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
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.10,
          title: Container(
            child: Expanded(
              child: Image.asset('images/logofondblanccropped.png',
                  fit: BoxFit.fill),
            ),
            margin: EdgeInsets.only(top: 20.0),
          ),
          elevation: 0,
        ),

        //-----------------------------------body
        body: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'ETES-VOUS ',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    margin: const EdgeInsets.only(top: 30),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 40.0),
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(
                            'images/recruiter.svg',
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.065,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Info_screen(
                                              entreprise: "",
                                              poste: "",
                                              linkedin: "",
                                              url: "",
                                            )));
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.035),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      'OU',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    margin: const EdgeInsets.only(top: 50),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 30,
                              left: MediaQuery.of(context).size.width * 0.25),
                          child: SvgPicture.asset(
                            'images/applicant.svg',
                          ),
                        ),
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.2),
                            height: MediaQuery.of(context).size.height * 0.065,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ApplicantInfo(
                                              entreprise: "",
                                              poste: "",
                                              domaine: "",
                                              expYears: "",
                                              linkedin: "",
                                              competence: const [],
                                              url: kDefaultImage,
                                            )));
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.035),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
