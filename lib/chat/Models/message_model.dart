import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderId;
  String text;
  Timestamp dateServer;
  Timestamp dateUser;

  MessageModel(
      {required this.senderId,
      required this.text,
      required this.dateServer,
      required this.dateUser});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'date': dateServer,
    };
  }
}
