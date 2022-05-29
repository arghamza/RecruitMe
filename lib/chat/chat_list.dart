import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_type_screen/chat/chat_screen.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatList extends StatefulWidget {
  const ChatList({Key? key, required this.accountType}) : super(key: key);

  final String accountType;

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
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MessagesStream(
          userNumber: widget.accountType == 'applicant' ? 'user2' : 'user1',
        ),
      ],
    );
  }
}

class ConversationBox extends StatelessWidget {
  const ConversationBox({
    Key? key,
    required this.user1,
    required this.user2,
    this.lastText = '',
    required this.username1,
    required this.username2,
  }) : super(key: key);

  final String user1;
  final String username1;
  final String user2;
  final String username2;
  final String lastText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
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
            child: Container(
              margin: const EdgeInsets.only(top: 8.0, bottom: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        loggedInUser.email == user1 ? username2 : username1,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      lastText,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
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
  const MessagesStream({Key? key, required this.userNumber}) : super(key: key);

  final String userNumber;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('chats')
          .where(userNumber, isEqualTo: loggedInUser.email)
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
        for (var conversation in conversations!) {
          final user1 = conversation.get('user1');
          final username1 = conversation.get('user1FullName');
          final user2 = conversation.get('user2');
          final username2 = conversation.get('user2FullName');
          final lastText = conversation.get('lastText');
          final messageBubble = ConversationBox(
            user1: user1,
            username1: username1,
            user2: user2,
            username2: username2,
            lastText: lastText,
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
