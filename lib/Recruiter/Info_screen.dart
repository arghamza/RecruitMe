// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this, camel_case_types, file_names, override_on_non_overriding_member, non_constant_identifier_names, prefer_adjacent_string_concatenation, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:user_type_screen/Recruiter/recruiter_screen.dart';

import '../model/recruiter_model.dart';
import '../model/user_model.dart';
import '../widget/custom_input_widget.dart';

class Info_screen extends StatefulWidget {
  const Info_screen({Key? key}) : super(key: key);

  @override
  State<Info_screen> createState() => _Info_screenState();
}

class _Info_screenState extends State<Info_screen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController entrepriseController = TextEditingController();
  final TextEditingController posteController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final entrepriseField = CustomInputWidget(
        inputController: entrepriseController, hintText: "exp: Google, ...");
    final posteField = CustomInputWidget(
        inputController: posteController, hintText: "exp:developpeur...");
    final linkedInField = CustomInputWidget(
        inputController: linkedinController, hintText: "LinkedIn");

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xff35ddaa),
      child: MaterialButton(
        onPressed: () {
          addUserTorecruiters();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Recruiter()));
        },
        child: Text("Confirmer",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xff35ddaa),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("images/avatar.png"),
                        radius: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                              "${loggedInUser.FirstName}" +
                                  "  ${loggedInUser.SecondName}",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              )),
                          Text("${loggedInUser.email}",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20),
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entreprise:',
                        style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Colors.black, letterSpacing: .5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  entrepriseField,
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Poste:',
                        style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Colors.black, letterSpacing: .5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  posteField,
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LinkedIn:',
                        style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Colors.black, letterSpacing: .5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  linkedInField,
                  SizedBox(
                    height: 120,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  addUserTorecruiters() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    if (_formKey.currentState!.validate()) {
      RecruiterModel recruiter = RecruiterModel();
      //writing all the values
      recruiter.linkedin = linkedinController.text;
      recruiter.poste = posteController.text;
      if (user != null) {
        recruiter.useruid = user.uid;
      } else {
        recruiter.useruid = "user uid not found ";
      }
      recruiter.entreprise = entrepriseController.text;

      var doc;
      doc = firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({"details": recruiter.toMap(), "userType": "recruiter"});
    } // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (context) => login()), (route) => false);
  }
}
