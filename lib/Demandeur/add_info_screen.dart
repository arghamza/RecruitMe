// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this, non_constant_identifier_names, override_on_non_overriding_member, avoid_print, prefer_adjacent_string_concatenation, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:user_type_screen/API/FireabaseApi.dart';
import 'package:user_type_screen/Demandeur/applicant.dart';
import 'package:user_type_screen/constants.dart';
import 'package:user_type_screen/widget/custom_input_widget.dart';

import '../model/applicant_model.dart';
import '../model/user_model.dart';
import '../widget/competences.dart';

class ApplicantInfo extends StatefulWidget {
  const ApplicantInfo({Key? key}) : super(key: key);

  @override
  State<ApplicantInfo> createState() => _ApplicantInfoState();
}

class _ApplicantInfoState extends State<ApplicantInfo> {
  @override
  final _formKey = GlobalKey<FormState>();
  final TextEditingController entrepriseController = TextEditingController();
  final TextEditingController posteController = TextEditingController();
  final TextEditingController linkedController = TextEditingController();
  final TextEditingController domaineController = TextEditingController();
  final TextEditingController expYearController = TextEditingController();
  TextfieldTagsController competencesController = TextfieldTagsController();

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

    final entrepriseField = CustomInputWidget(
        inputController: entrepriseController, hintText: "exp: Google, ...");
    final posteField = CustomInputWidget(
        inputController: posteController, hintText: "exp:developpeur...");
    final linkedInField = CustomInputWidget(
        inputController: linkedController, hintText: "LinkedIn");
    final domaineField = CustomInputWidget(
        inputController: domaineController, hintText: "exp:informatique...");
    final yearsField = CustomInputWidget(
        inputController: expYearController, hintText: "exp:0-5...");
    final competencesField =
        CompetenceWidget(competencesController: competencesController);

    final loginButton = confirmButton(
      context,
      () {
        addUserToapplicants();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Applicant()));
      },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      'Domaine:',
                      style: kFormsTextFont,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    domaineField,
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Poste actuel:',
                          style: kFormsTextFont,
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
                          style: kFormsTextFont,
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
                          style: kFormsTextFont,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    yearsField,
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LinkedIn:',
                          style: kFormsTextFont,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    linkedInField,
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cv:',
                            style: kFormsTextFont,
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
                      width: 10,
                    ),
                    competencesField,
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

  Material confirmButton(BuildContext context, VoidCallback onPressed) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xff35ddaa),
      child: MaterialButton(
        onPressed: onPressed,
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

  addUserToapplicants() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (_formKey.currentState!.validate()) {
      ApplicantModel applicant = ApplicantModel();
      //writing all the values
      applicant.linkedin = linkedController.text;
      applicant.poste = posteController.text;
      applicant.domaine = domaineController.text;
      applicant.entreprise = entrepriseController.text;
      applicant.expYears = int.parse(expYearController.text);
      applicant.cv = "";
      if (user != null) {
        applicant.useruid = user.uid;
      } else {
        applicant.useruid = "user uid not found ";
      }
      //
      var doc;
      doc = firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({"details": applicant.toMap(), "userType": "applicant"});
    } // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (context) => login()), (route) => false);
  }
}
