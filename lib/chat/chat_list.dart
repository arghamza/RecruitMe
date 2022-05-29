import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_type_screen/chat/chat_screen.dart';
import 'package:user_type_screen/constants.dart';

import 'chatConstants.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  static const String id = "chat_screen";

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        MessagesStream(),
      ],
    );
  }
}

class ConversationBox extends StatelessWidget {
  const ConversationBox(
      {Key? key, required this.user1, required this.user2, required this.isMe})
      : super(key: key);

  final String user1;
  final String user2;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            child: Text(
              loggedInUser.email == user1 ? user2 : user1,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    interlocutorEmail:
                        loggedInUser.email == user1 ? user2 : user1,
                    isRecruiter: loggedInUser.email == user1 ? true : false,
                  ),
                ),
              );
            },
            child: const Text(
              'Some random Stuff',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('chats')
          .where('user2', isEqualTo: loggedInUser.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final conversations = snapshot.data?.docs.reversed;
        List<ConversationBox> messageBubbles = [];
        for (var message in conversations!) {
          final user1 = message.get('user1');
          final user2 = message.get('user2');
          final currentUser = loggedInUser.email;

          final messageBubble = ConversationBox(
            user1: user1,
            user2: user2,
            isMe: currentUser == user2,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
