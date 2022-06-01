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
import '../widget/project_app_bar_basic.dart';

class ApplicantInfo extends StatefulWidget {
  const ApplicantInfo(
      {Key? key,
      required this.entreprise,
      required this.poste,
      required this.linkedin,
      required this.domaine,
      required this.expYears,
      required this.competence,
      required this.url})
      : super(key: key);
  final String entreprise;
  final String poste;
  final String linkedin;
  final String domaine;
  final String expYears;
  final List<dynamic> competence;
  final String url;

  @override
  State<ApplicantInfo> createState() => _ApplicantInfoState();
}

class _ApplicantInfoState extends State<ApplicantInfo> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController entrepriseController = TextEditingController();
  TextEditingController posteController = TextEditingController();
  TextEditingController linkedController = TextEditingController();
  TextEditingController domaineController = TextEditingController();
  TextEditingController expYearController = TextEditingController();
  TextfieldTagsController competencesController = TextfieldTagsController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UploadTask? task;
  File? file, file2;
  static String url = "";
  String cvurl = "";

  @override
  void initState() {
    super.initState();
    entrepriseController = TextEditingController(text: widget.entreprise);
    posteController = TextEditingController(text: widget.poste);
    linkedController = TextEditingController(text: widget.linkedin);
    domaineController = TextEditingController(text: widget.domaine);
    expYearController = TextEditingController(text: widget.expYears);
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
        appBar: projectAppBarBasic(context),
        body: Flexible(
          child: Container(
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
                            backgroundImage: url == ""
                                ? AssetImage("images/avatar.png")
                                : Image.network(
                                    url.toString(),
                                    width: 40,
                                    height: 40,
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
                            width: 2,
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

  selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));

    uploadFile();
  }

  Future uploadFile() async {
    if (file == null) {
      return;
    }
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final fileName = file!.path.split('/').last;
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    cvurl = urlDownload;
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

    print('Download-Link: $urlDownload');
    setState(() {
      url = urlDownload;
    });
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update({"img": urlDownload});
  }

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
      applicant.cv = cvurl;
      applicant.competences = competencesController.getTags;
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
