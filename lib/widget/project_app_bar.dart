import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_type_screen/Demandeur/add_info_screen.dart';
import 'package:user_type_screen/Demandeur/applicant_profile.dart';
import 'package:user_type_screen/Recruiter/recruiter_profile.dart';
import 'package:user_type_screen/model/user_model.dart';

import '../Recruiter/Info_screen.dart';

AppBar projectAppBar(UserModel? user, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
    actions: [
      Container(
        child: const Flexible(
          child: Icon(
            FontAwesomeIcons.bell,
            color: Color(0xff35ddaa),
          ),
        ),
        padding: const EdgeInsets.only(right: 16.0, top: 10.0),
      )
    ],
    leading: Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Flexible(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => user?.userType == "applicant"
                    ? ApplicantProfile(user: user!)
                    : RecruiterProfile(user: user!)));
          },
          child: const Icon(
            Icons.person,
            color: Color(0xff35ddaa),
          ),
        ),
      ),
    ),
    title: Container(
      child: Flexible(
          child:
              Image.asset('images/logofondblanccropped.png', fit: BoxFit.fill)),
      padding: const EdgeInsets.only(top: 20.0),
    ),
  );
}
