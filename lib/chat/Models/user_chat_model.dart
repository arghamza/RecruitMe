class UserChatModel {
  String uid;
  String email;
  String fullName;
  String userType;
  String imgURL;

  UserChatModel(
      {required this.uid,
      required this.email,
      required this.fullName,
      required this.userType,
      this.imgURL = ''});

  factory UserChatModel.fromMap(map) {
    return UserChatModel(
        uid: map['uid'],
        email: map['email'],
        fullName: map['FirstName'] + ' ' + map['SecondName'],
        userType: map['userType'],
        imgURL: map['img'] ?? '');
  }
}
