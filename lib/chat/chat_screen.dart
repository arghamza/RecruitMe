import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';
import 'package:user_type_screen/chat/MessagesWidgets/messages_stream.dart';
import 'package:user_type_screen/chat/Controllers/messages_controller.dart';
import 'package:user_type_screen/chat/Models/conversation_model.dart';

import 'chatConstants.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key, required this.isRecruiter, required this.conversationModel})
      : super(key: key);
  final bool isRecruiter;
  final ConversationModel conversationModel;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final MessagesController chatsController = MessagesController();
  late String interlocutorEmail;
  late String messageText;

  @override
  void initState() {
    super.initState();
    loggedInUser = chatsController.getCurrentUser(_auth)!;
    interlocutorEmail = widget.isRecruiter
        ? widget.conversationModel.applicantId
        : widget.conversationModel.recruiterId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡ $interlocutorEmail'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(
              conversationModel: widget.conversationModel,
              isRecruiter: widget.isRecruiter,
              loggedInUserEmail: loggedInUser.email!,
              firestore: _fireStore,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      DateTime startDate = DateTime.now().toLocal();
                      int offset = await NTP.getNtpOffset(localTime: startDate);
                      messageTextController.clear();
                      if (messageText != '') {
                        _fireStore
                            .collection('chats')
                            .doc(widget.conversationModel.id)
                            .collection('conversation')
                            .add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'date': startDate.add(Duration(milliseconds: offset))
                        });
                        _fireStore
                            .collection('chats')
                            .doc(widget.conversationModel.id)
                            .update({'lastText': messageText});
                      }
                      messageText = '';
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
