// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:textfield_tags/textfield_tags.dart';
import 'package:user_type_screen/Recruiter/recruiter_screen.dart';
import 'package:user_type_screen/constants.dart';
import 'package:user_type_screen/model/offre_model.dart';
import 'package:user_type_screen/widget/confirmbutton.dart';

import '../widget/competences.dart';
import '../widget/custom_input_widget.dart';

class CreationOffre extends StatefulWidget {
  const CreationOffre({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<CreationOffre> createState() => _CreationOffreState();
}

class _CreationOffreState extends State<CreationOffre> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController titreController = TextEditingController();
  final TextEditingController entrepriseController = TextEditingController();
  final TextEditingController posteController = TextEditingController();
  final TextEditingController domaineController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  TextfieldTagsController competencesController = TextfieldTagsController();
  @override
  Widget build(BuildContext context) {
    final titreField = CustomInputWidget(
        inputController: titreController,
        hintText: "exp: senior data engineer...");
    final entrepriseField = CustomInputWidget(
        inputController: entrepriseController,
        hintText: "exp: senior data engineer...");
    final posteField = CustomInputWidget(
        inputController: posteController, hintText: "exp: chef de projet ...");
    final domaineField = CustomInputWidget(
        inputController: domaineController, hintText: "exp: IT,finance...");
    final detailsField = CustomInputWidget(
        inputController: detailsController, hintText: "exp: job details ...");
    final competencesField =
        CompetenceWidget(competencesController: competencesController);

    final confirmButton = ConfirmButton(onPressed: () {
      postOfferToFirestore();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Recruiter()));
    });
    //---------------------------------------------------------------------RETURN----------------------------------
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff35ddaa),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 80,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                    width: 300,
                    height: 50,
                    child: Text("Création d'offre  ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ))),
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Titre de l\'offre:',
                                style: kFormsTextFont,
                              ),
                              titreField,
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Entreprise:',
                                style: kFormsTextFont,
                              ),
                              entrepriseField,
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Poste:',
                                style: kFormsTextFont,
                              ),
                              posteField,
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Domaine :',
                                style: kFormsTextFont,
                              ),
                              domaineField,
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'A propos du poste :',
                                style: kFormsTextFont,
                              ),
                              detailsField,
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Compétences :',
                                style: kFormsTextFont,
                              ),
                              competencesField,
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                        confirmButton
                      ],
                    ))
              ]),
            )));
  }

  postOfferToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    if (_formKey.currentState!.validate()) {
      OffreModel offre = OffreModel();
      //writing all the values
      offre.titre = titreController.text;
      offre.poste = posteController.text;
      if (user != null) {
        offre.useruid = user.uid;
      } else {
        offre.useruid = "user uid not found ";
      }
      offre.entreprise = entrepriseController.text;
      offre.domaine = domaineController.text;
      offre.details = detailsController.text;
      offre.competences = competencesController.getTags;

      var id;
      await firebaseFirestore
          .collection("offres")
          .add(offre.toMap())
          .then((value) {
        id = value.id;
      });
      await firebaseFirestore
          .collection("offres")
          .doc(id)
          .update({"offerId": id});
      offre.offerId = id;
      List liste_offre = [];
      liste_offre.add(offre.toMap());
      Fluttertoast.showToast(msg: "Offre created successfully");
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({"offres": FieldValue.arrayUnion(liste_offre)});
    } // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (context) => login()), (route) => false);
  }
}
