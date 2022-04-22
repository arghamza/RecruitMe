// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/user_model.dart';

class Info_screen extends StatefulWidget {
  const Info_screen({Key? key}) : super(key: key);

  @override
  State<Info_screen> createState() => _Info_screenState();
}

class _Info_screenState extends State<Info_screen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final TextEditingController entrepriseController =
      new TextEditingController();
  final TextEditingController posteController = new TextEditingController();

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
    final entrepriseField = TextFormField(
        autofocus: false,
        controller: entrepriseController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          entrepriseController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 190, 244, 227),
            filled: true,
            prefixIcon: Icon(Icons.apartment),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Entreprise",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            )));

    final posteField = TextFormField(
        autofocus: false,
        controller: posteController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          posteController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 190, 244, 227),
            filled: true,
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Poste",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            )));

    final LinkedInField = TextFormField(
        autofocus: false,
        controller: posteController,
        keyboardType: TextInputType.url,
        onSaved: (value) {
          posteController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 190, 244, 227),
            filled: true,
            prefixIcon: Icon(FontAwesomeIcons.linkedinIn),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "LinkedIn",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            )));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xff35ddaa),
      child: MaterialButton(
        onPressed: () {},
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
                        width: 15,
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
                  LinkedInField,
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
}
