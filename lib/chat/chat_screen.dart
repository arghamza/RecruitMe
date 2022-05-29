import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_type_screen/constants.dart';
import 'package:intl/intl.dart';

import 'chatConstants.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key, required this.interlocutorEmail, required this.isRecruiter})
      : super(key: key);

  final String interlocutorEmail;
  final bool isRecruiter;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  late String docId;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    docId = widget.isRecruiter
        ? loggedInUser.email! + '+' + widget.interlocutorEmail
        : widget.interlocutorEmail + '+' + loggedInUser.email!;
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
        title: Text('⚡ ${widget.interlocutorEmail}'),
        backgroundColor: kAppColorTheme,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(
              isRecruiter: widget.isRecruiter,
              interlocutor: widget.interlocutorEmail,
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
                    onPressed: () {
                      messageTextController.clear();
                      if (messageText != '') {
                        _fireStore
                            .collection('chats')
                            .doc(docId)
                            .collection('conversation')
                            .add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'date': DateTime.now()
                        });
                        _fireStore
                            .collection('chats')
                            .doc(docId)
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

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.dateSent,
      required this.text,
      required this.isMe})
      : super(key: key);

  final Timestamp dateSent;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('d/M/y').format(DateTime.fromMillisecondsSinceEpoch(
                dateSent.millisecondsSinceEpoch)),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream(
      {Key? key, required this.interlocutor, required this.isRecruiter})
      : super(key: key);

  final String interlocutor;
  final bool isRecruiter;

  @override
  Widget build(BuildContext context) {
    final String docId = isRecruiter
        ? loggedInUser.email! + '+' + interlocutor
        : interlocutor + '+' + loggedInUser.email!;
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('chats')
          .doc(docId)
          .collection('conversation')
          .orderBy('date')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages!) {
          final messageText = message.get('text');
          final sender = message.get('sender');
          final dateSent = message.get('date');
          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            dateSent: dateSent,
            text: messageText,
            isMe: currentUser == sender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
