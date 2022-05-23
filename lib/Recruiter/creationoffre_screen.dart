// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:textfield_tags/textfield_tags.dart';
import 'package:user_type_screen/Recruiter/recruiter_screen.dart';
import 'package:user_type_screen/model/offre_model.dart';

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
  final TextEditingController TitreController = TextEditingController();
  final TextEditingController entrepriseController = TextEditingController();
  final TextEditingController posteController = TextEditingController();
  final TextEditingController domaineController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  TextfieldTagsController competencesController = TextfieldTagsController();
  @override
  Widget build(BuildContext context) {
    final titreField = TextFormField(
      autofocus: false,
      controller: TitreController,
      onSaved: (value) {
        TitreController.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter a title ");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a valid title (Min 3 char)");
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 190, 244, 227),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        hintText: "exp: senior data engineer...",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );
    final entrepriseField = TextFormField(
      autofocus: false,
      controller: entrepriseController,
      onSaved: (value) {
        entrepriseController.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter a name ");
        }

        return null;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 190, 244, 227),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        hintText: "exp: Google,IBM ...",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );
    final posteField = TextFormField(
      autofocus: false,
      controller: posteController,
      onSaved: (value) {
        posteController.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter a name ");
        }

        return null;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 190, 244, 227),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        hintText: "exp: chef de projet ...",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );
    final domaineField = TextFormField(
      autofocus: false,
      controller: domaineController,
      onSaved: (value) {
        domaineController.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter a name ");
        }

        return null;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 190, 244, 227),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        hintText: "exp: IT,finance...",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );
    final detailsField = TextFormField(
      autofocus: false,
      controller: detailsController,
      onSaved: (value) {
        detailsController.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter a name ");
        }

        return null;
      },
      maxLines: 5,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 190, 244, 227),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        hintText: "exp: job details ...",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );

    //tags
    final competencesField = TextFieldTags(
      textfieldTagsController: competencesController,
      initialTags: const ['Leadership', 'Flutter'],
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (competencesController.getTags!.contains(tag)) {
          return 'you already entered that';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                helperText: 'ajoutez une compétence ...',
                helperStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: competencesController.hasTags ? '' : "...",
                errorText: error,
                prefixIconConstraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: sc,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: tags.map((String tag) {
                          return Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color:Color.fromARGB(255, 24, 165, 123)),

                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: const Color.fromARGB(255, 190, 244, 227),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '$tag',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          );
        });
      },
    );
    final ConfirmButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xff35ddaa),
      child: MaterialButton(
        onPressed: () {
          postOfferToFirestore();
        },
        child: Text(
          "Confirmer",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width - 200,
      ),
    );
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
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Titre de l\'offre:',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black, letterSpacing: .5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          titreField,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Entreprise:',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black, letterSpacing: .5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          entrepriseField,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Poste:',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black, letterSpacing: .5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          posteField,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Domaine :',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black, letterSpacing: .5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          domaineField,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'A propos du poste :',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black, letterSpacing: .5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          detailsField,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Compétences :',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black, letterSpacing: .5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          competencesField,
                          const SizedBox(
                            height: 20,
                          ),
                          ConfirmButton
                        ])))
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
      offre.titre = TitreController.text;
      offre.poste = posteController.text;
      if (user != null) {
        offre.recruiteruid = user.uid;
      } else {
        offre.recruiteruid = "user uid not found ";
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

      var liste_offre = [];
      liste_offre.add(id);
      Fluttertoast.showToast(msg: "Offre created successfully");
      var doc;
      firebaseFirestore
          .collection("recruteurs")
          .where("useruid", isEqualTo: user?.uid)
          .get()
          .then((query) => {
                if (query != null)
                  {
                    doc = firebaseFirestore
                        .collection("recruteurs")
                        .doc(query.docs[0].id)
                        .update({"offres": FieldValue.arrayUnion(liste_offre)})
                  }
                else
                  {print("shit not working bruh !!!!!!!!!!!!!!!!!!!!!!!!!!!!")}
              });
    } // Navigator.pushAndRemoveUntil(context,
    //     MaterialPageRoute(builder: (context) => login()), (route) => false);
  }
}
