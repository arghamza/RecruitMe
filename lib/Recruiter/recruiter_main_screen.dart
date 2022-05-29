// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, annotate_overrides
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/chat/chat_screen.dart';
import 'package:user_type_screen/model/offre_model.dart';
import 'package:user_type_screen/model/user_model.dart';

class RecruiterMainScreen extends StatefulWidget {
  const RecruiterMainScreen({Key? key, required this.offerId})
      : super(key: key);
  final String? offerId;
  @override
  State<RecruiterMainScreen> createState() => _RecruiterMainScreen();
}

class _RecruiterMainScreen extends State<RecruiterMainScreen> {
  static int i = 0;

  List? applicantsIds;
  List<UserModel> applicants = [];
  UserModel? applicant;
  UserModel? recruiter;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      recruiter = UserModel.fromMap(value.data());
      setState(() {});
    });
    Future.delayed(const Duration(milliseconds: 1), () {
      firebaseFirestore
          .collection("offres")
          .doc(widget.offerId?.trim())
          .get()
          .then((value) async {
        print(value.data()!['applicants'][0]);
        applicantsIds = value.data()!['applicants'];
        for (var id in applicantsIds!) {
          await firebaseFirestore
              .collection("users")
              .doc(id)
              .get()
              .then((v) => {applicants.add(UserModel.fromMap(v.data()))});
        }
        print(applicants[0].email);
        setState(() {
          applicant = applicants[0];
        });
      });
    });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.person,
          color: const Color(0xff35ddaa),
        ),
        title: Row(
          children: [
            Container(
              child: Image.asset('images/logofondblanccropped.png',
                  fit: BoxFit.fill),
              margin: const EdgeInsets.only(left: 50, top: 10.0),
              width: 170,
            ),
            SizedBox(
              width: 65,
            ),
            Icon(
              FontAwesomeIcons.bell,
              color: const Color(0xff35ddaa),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: width - 40,
              height: height - 240,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 244, 227),
                  borderRadius: BorderRadius.circular(60)),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("images/avatar.png"),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 30),
                    child: Text(
                      '${applicant?.FirstName}' + '${applicant?.SecondName}',
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
                      text: 'Email :   ',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '${applicant?.email}',
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
                      text: 'Années d\'experience:   ',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '${applicant?.details!["expYears"]}',
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
                      text: '${applicant?.details!["domaine"]}',
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
                      text: 'Poste actual :   ',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '${applicant?.details!["poste"]}',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 18),
                          fontWeight: FontWeight.w300),
                    ),
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Compétences :   ',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "getCompetences()",
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 600, left: 25),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.red),
                  child: Icon(
                    FontAwesomeIcons.xmark,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      createChat(recruiter!, applicant!);
                      if (i + 1 > applicants.length) {
                        i = 0;
                      } else {
                        i++;
                        applicant = applicants[i];
                      }
                    });
                  },
                  child: Container(
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void createChat(UserModel recruiter, UserModel applicant) {
    final String? recruiterFullName =
        recruiter.FirstName! + recruiter.SecondName!;
    final String applicantFullName =
        applicant.FirstName! + applicant.SecondName!;

    firebaseFirestore
        .collection('chats')
        .doc('${recruiter.email}+${applicant.email}')
        .collection('conversation')
        .add({});
    firebaseFirestore
        .collection('chats')
        .doc('${recruiter.email}+${applicant.email}')
        .set({
      'user1': recruiter.email,
      'user1FullName': recruiterFullName,
      'user2': applicant.email,
      'user2FullName': applicantFullName
    });
  }

//   String getCompetences() {
//     String cpts = "\n";
//     for (String word in applicant?.details!["competences"]) {
//       cpts += word + " \n";
//     }
//     return cpts;
//   }
}
