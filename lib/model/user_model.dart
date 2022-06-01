// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? uid;
  String? email;
  String? FirstName;
  String? SecondName;
  String? userType;
  Map<String, dynamic>? details;
  List<dynamic>? offres;
  String? img;

  UserModel({
    this.uid = '',
    this.email = '',
    this.FirstName = '',
    this.SecondName = '',
    this.userType = '',
    this.details,
    this.offres = const [],
    this.img,
  });
  //data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        FirstName: map['FirstName'],
        SecondName: map['SecondName'],
        userType: map['userType'],
        details: map['details'],
        offres: map['offres'],
        img: map['img']);
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
      'offres': offres,
      'img': img
    };
  }
}
