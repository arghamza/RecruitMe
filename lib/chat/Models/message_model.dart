import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderId;
  String text;
  Timestamp date;

  MessageModel(
      {required this.senderId, required this.text, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'date': date,
    };
  }
}
