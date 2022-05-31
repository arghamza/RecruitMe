import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Controllers/conversations_controller.dart';

class ConversationsStream extends StatelessWidget {
  ConversationsStream(
      {Key? key,
      required this.isRecruiter,
      required this.fireStore,
      required this.loggedInUserEmail})
      : super(key: key);
  final String loggedInUserEmail;
  final FirebaseFirestore fireStore;
  final bool isRecruiter;
  final ConversationsController conversationsController =
      ConversationsController();

  @override
  Widget build(BuildContext context) {
    return conversationsController.generateListConversations(
        context: context,
        fireStore: fireStore,
        loggedInUserEmail: loggedInUserEmail,
        isRecruiter: isRecruiter);
  }
}
