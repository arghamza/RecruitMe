// ignore_for_file: unnecessary_this, prefer_const_constructors, camel_case_types, body_might_complete_normally_nullable, unused_local_variable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Login/registration_screen.dart';
import 'package:user_type_screen/model/user_model.dart';

import '../Demandeur/applicant.dart';
import '../Recruiter/recruiter_screen.dart';
import '../admin/admin_screen.dart';
import 'choice_screen.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your email");
          }

          if (!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9+_,-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 190, 244, 227),
            filled: true,
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            )));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please Enter your password");
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter a valid password (Min 6 char)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        obscureText: true,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 190, 244, 227),
            filled: true,
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
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
          signIn(emailController.text, passwordController.text);
        },
        child: Text("Login",
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xff35ddaa),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 400,
                      child: SvgPicture.asset(
                        "images/Login.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email:',
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
                    emailField,
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password:',
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
                    passwordField,
                    SizedBox(
                      height: 25,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()));
                      },
                      child: Text(
                        "Créer un compte",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: const Color(0xff35ddaa)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void signIn(String email, String password) async {
    var doc;
    Widget widget = ChoiceScreen();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    UserModel user;
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: '"login successful'),
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid.user!.uid)
                    .get()
                    .then((value) {
                  UserModel loggedInUser = UserModel.fromMap(value.data());
                  switch (loggedInUser.userType) {
                    case " ":
                      widget = ChoiceScreen();
                      break;
                    case "applicant":
                      widget = Applicant();
                      break;
                    case "recruiter":
                      widget = Recruiter();
                      break;
                    case "admin":
                      widget = AdminScreen();
                      break;
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => widget));
                })
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
