import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitme/Login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff35ddaa),
      body: Container(
          color: const Color(0xff35ddaa),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: Image.asset(
                  "images/logofondvert.png",
                  fit: BoxFit.contain,
                  height: 100,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: SvgPicture.asset(
                  "images/HomePage.svg",
                  fit: BoxFit.contain,
                  width: 350,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: width - 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: Color(0xff35ddaa),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Text("Connexion avec Email",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Color(0xff35ddaa),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: width - 50,
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
                    Container(
                      margin: const EdgeInsets.only(left: 25),
                      child: Text("Connexion avec Google",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Color(0xff35ddaa),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              ),
            ],
          )),
    );
  }
}
