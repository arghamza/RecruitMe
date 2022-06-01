// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this, camel_case_types, file_names, override_on_non_overriding_member, non_constant_identifier_names, prefer_adjacent_string_concatenation, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:user_type_screen/Recruiter/recruiter_screen.dart';
import 'package:user_type_screen/widget/project_app_bar.dart';

import '../API/FireabaseApi.dart';
import '../model/recruiter_model.dart';
import '../model/user_model.dart';
import '../widget/custom_input_widget.dart';

class Info_screen extends StatefulWidget {
  const Info_screen(
      {Key? key,
      required this.entreprise,
      required this.poste,
      required this.linkedin,
      required this.url})
      : super(key: key);
  final String entreprise;
  final String poste;
  final String linkedin;
  final String url;

  @override
  State<Info_screen> createState() => _Info_screenState();
}

class _Info_screenState extends State<Info_screen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController entrepriseController = TextEditingController();
  TextEditingController posteController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UploadTask? task;
  File? file2;
  String url = "";
  @override
  void initState() {
    super.initState();
    entrepriseController = TextEditingController(text: widget.entreprise);
    posteController = TextEditingController(text: widget.poste);
    linkedinController = TextEditingController(text: widget.linkedin);
    url = widget.url;

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
        appBar: projectAppBar(loggedInUser, context),
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
                        backgroundImage: url == ""
                            ? AssetImage("images/avatar.png")
                            : Image.network(
                                url.toString(),
                                width: 60,
                                height: 60,
                              ).image,
                        radius: 60,
                      ),
                      GestureDetector(
                          onTap: selectImage,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 90),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                                "${loggedInUser.FirstName}" +
                                    "  ${loggedInUser.SecondName}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                )),
                            Text("${loggedInUser.email}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                )),
                          ],
                        ),
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

  selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file2 = File(path));

    uploadImage();
  }

  Future uploadImage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (file2 == null) {
      return;
    }

    final fileName = file2!.path.split('/').last;
    final destination = 'images/$fileName';

    task = FirebaseApi.uploadFile(destination, file2!);
    setState(() {});

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    if (kDebugMode) {
      print('Download-Link: $urlDownload');
    }
    setState(() {
      url = urlDownload;
    });
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update({"img": urlDownload});
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
