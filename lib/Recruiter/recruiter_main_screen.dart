// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, annotate_overrides
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/model/user_model.dart';

import '../widget/project_app_bar.dart';
import '../widget/rich_text_line.dart';

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
      setState(() {
        recruiter = UserModel.fromMap(value.data());
      });
    });

    firebaseFirestore
        .collection("offres")
        .doc(widget.offerId?.trim())
        .get()
        .then((value) async {
      applicantsIds = value.data()!['applicants'];
      for (var id in applicantsIds!) {
        await firebaseFirestore.collection("users").doc(id).get().then((v) => {
              setState(() {
                applicants.add(UserModel.fromMap(v.data()));
              })
            });
      }
      setState(() {
        applicant = applicants[0];
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(recruiter, context),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 30.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 244, 227),
                  borderRadius: BorderRadius.circular(60)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Expanded(
                        flex: 0,
                        child: CircleAvatar(
                            backgroundImage: AssetImage("images/avatar.png"))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    flex: 0,
                    child: Text(
                      '${applicant?.FirstName} ${applicant?.SecondName}',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 30),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        RichTextLine(
                          text: "${applicant?.email}",
                          title: 'Email :  ',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RichTextLine(
                          text: "${applicant?.details!["expYears"].toString()}",
                          title: 'Années d\'expérience :  ',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RichTextLine(
                          text: "${applicant?.details!["domaine"]}",
                          title: 'Domaine :  ',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RichTextLine(
                          text: "${applicant?.details!["poste"]}",
                          title: 'Poste actuel :  ',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        applicant?.details!['competences'] == null
                            ? const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                              )
                            : RichTextLine(
                                text: getCompetences(
                                    applicant?.details!["competences"]),
                                title: 'Compétences :  ',
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (i + 1 > applicants.length) {
                      i = 0;
                    } else {
                      i++;
                      applicant = applicants[i];
                    }
                  },
                  child: Container(
                    //margin: const EdgeInsets.only(left: 25),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: Colors.red),
                    child: Icon(
                      FontAwesomeIcons.xmark,
                      size: 40,
                      color: Colors.black,
                    ),
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
                      color: Colors.black,
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
        recruiter.FirstName! + ' ' + recruiter.SecondName!;
    final String applicantFullName =
        applicant.FirstName! + ' ' + applicant.SecondName!;

    firebaseFirestore
        .collection('chats')
        .doc('${recruiter.email}+${applicant.email}')
        .collection('conversation')
        .add({});
    firebaseFirestore
        .collection('chats')
        .doc('${recruiter.email}+${applicant.email}')
        .set({
      'lastText': '',
      'lastTextDate': Timestamp.now(),
      'user1': recruiter.email,
      'user1FullName': recruiterFullName,
      'user2': applicant.email,
      'user2FullName': applicantFullName
    });
  }

  String getCompetences(List<dynamic>? list) {
    String cpts = "\n";
    for (String word in list!) {
      cpts += word + " \n";
    }
    return cpts;
  }
}
