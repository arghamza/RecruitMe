// ignore_for_file: non_constant_identifier_names

import 'package:user_type_screen/Demandeur/applicant_home.dart';
import 'package:user_type_screen/model/recruiter_model.dart';

class UserModel {
  String? uid;
  String? email;
  String? FirstName;
  String? SecondName;
  String? userType;
  Map<String, dynamic>? details;
  List<dynamic>? offres;

  UserModel(
      {this.uid = '',
      this.email = '',
      this.FirstName = '',
      this.SecondName = '',
      this.userType = '',
      this.details = const {'': ''},
      this.offres = const []});
  //data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        FirstName: map['FirstName'],
        SecondName: map['SecondName'],
        userType: map['userType'],
        details: map['details'],
        offres: map['offres']);
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'FirstName': FirstName,
      'SecondName': SecondName,
      'userType': userType,
      'details': details,
      'offres': offres
    };
  }
}
