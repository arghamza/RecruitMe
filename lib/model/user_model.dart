class UserModel {
  String? uid;
  String? email;
  String? FirstName;
  String? SecondName;

  UserModel({this.uid, this.email, this.FirstName, this.SecondName});
  //data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      FirstName: map['FirstName'],
      SecondName: map['SecondName'],
    );
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'FirstName': FirstName,
      'SecondName': SecondName,
    };
  }
}
