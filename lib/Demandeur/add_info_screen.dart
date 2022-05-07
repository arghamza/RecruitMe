// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/API/FireabaseApi.dart';
import 'package:user_type_screen/Demandeur/buttom_navbar.dart';

import '../model/user_model.dart';

class ApplicantScreen extends StatefulWidget {
  const ApplicantScreen({Key? key}) : super(key: key);

  @override
  State<ApplicantScreen> createState() => _ApplicantScreenState();
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final TextEditingController entrepriseController =
      new TextEditingController();
  final TextEditingController posteController = new TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UploadTask? task;
  File? file;
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
    final fileName =
        file != null ? file!.path.split('/').last : 'No File Selected';

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
            hintText: "exp:Google...",
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
            hintText: "exp:developpeur...",
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

    final DomaineField = TextFormField(
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
            prefixIcon: Icon(FontAwesomeIcons.briefcase),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "exp:informatique...",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            )));

    final YearsField = TextFormField(
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
            prefixIcon: Icon(FontAwesomeIcons.calendar),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "exp:0-5...",
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
        onPressed: () {
          uploadFile();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
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
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 0,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Domaine:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black, letterSpacing: .5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DomaineField,
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Poste actuel:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black, letterSpacing: .5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    posteField,
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entreprise actuelle:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black, letterSpacing: .5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    entrepriseField,
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Années d\'expérience:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black, letterSpacing: .5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    YearsField,
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LinkedIn:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black, letterSpacing: .5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LinkedInField,
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cv:',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black, letterSpacing: .5),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                              onTap: selectFile,
                              child: Icon(
                                FontAwesomeIcons.fileCirclePlus,
                                color: const Color(0xff35ddaa),
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            fileName,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black, letterSpacing: .5),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          task != null ? buildUploadStatus(task!) : Container(),
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = file!.path.split('/').last;
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
