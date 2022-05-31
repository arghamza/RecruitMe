import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ntp/ntp.dart';
import 'package:user_type_screen/chat/MessagesWidgets/messages_stream.dart';
import 'package:user_type_screen/chat/Controllers/messages_controller.dart';
import 'package:user_type_screen/chat/Models/conversation_model.dart';

import 'chatConstants.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.isRecruiter,
      required this.conversationModel,
      this.interlocutorImgURL = ''})
      : super(key: key);
  final String interlocutorImgURL;
  final bool isRecruiter;
  final ConversationModel conversationModel;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final MessagesController chatsController = MessagesController();
  late String interlocutorFullName;
  late String messageText;

  @override
  void initState() {
    super.initState();
    loggedInUser = chatsController.getCurrentUser(_auth)!;
    interlocutorFullName = widget.isRecruiter
        ? widget.conversationModel.applicantFullName
        : widget.conversationModel.recruiterFullName;
  }

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      minRadius: 12.0,
      maxRadius: 19.0,
      backgroundImage: NetworkImage(
        widget.interlocutorImgURL,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xff35ddaa), //change your color here
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: const Icon(FontAwesomeIcons.phone), onPressed: () {}),
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: IconButton(
                icon: const Icon(FontAwesomeIcons.video), onPressed: () {}),
          ),
        ],
        title: Column(
          children: [
            CircleAvatar(
              minRadius: 12.0,
              maxRadius: 22.0,
              backgroundImage: NetworkImage(
                widget.interlocutorImgURL,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 3.0),
              child: Text(
                interlocutorFullName,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
              ),
            ),
          ],
        ),
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
              interlocutorAvatar: avatar,
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
                        final dateServer =
                            startDate.add(Duration(milliseconds: offset));
                        _fireStore
                            .collection('chats')
                            .doc(widget.conversationModel.id)
                            .collection('conversation')
                            .add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'dateServer': dateServer,
                          'dateUser': DateTime.now()
                        });
                        _fireStore
                            .collection('chats')
                            .doc(widget.conversationModel.id)
                            .update({'lastText': messageText});
                        _fireStore
                            .collection('chats')
                            .doc(widget.conversationModel.id)
                            .update({'lastTextDate': dateServer});
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
