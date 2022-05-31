import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_type_screen/chat/Controllers/conversations_controller.dart';
import 'package:user_type_screen/chat/Controllers/messages_controller.dart';
import 'package:user_type_screen/chat/ConversationsWidgets/conversations_stream.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ConversationsList extends StatefulWidget {
  const ConversationsList({Key? key, required this.accountType})
      : super(key: key);
  final String accountType;

  @override
  _ConversationsListState createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final MessagesController chatsController = MessagesController();
  final ConversationsController conversationsController =
      ConversationsController();
  late String messageText;

  @override
  void initState() {
    super.initState();
    loggedInUser = chatsController.getCurrentUser(_auth)!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ConversationsStream(
            isRecruiter: widget.accountType == 'applicant' ? false : true,
            fireStore: _fireStore,
            loggedInUserEmail: loggedInUser.email!),
      ],
    );
  }
}
