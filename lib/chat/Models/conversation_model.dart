import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  String id;
  String applicantId;
  String applicantFullName;
  String applicantImg;
  String recruiterId;
  String recruiterFullName;
  String recruiterImg;
  String lastText;
  Timestamp lastTextDate;

  ConversationModel(
      {required this.id,
      required this.applicantId,
      required this.applicantFullName,
      this.applicantImg = '',
      required this.recruiterId,
      required this.recruiterFullName,
      this.recruiterImg = '',
      required this.lastText,
      required this.lastTextDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recruiterId': recruiterId,
      'recruiterFullName': recruiterFullName,
      'applicantId': applicantId,
      'applicantFullName': applicantFullName,
      'lastText': lastText,
    };
  }
}
