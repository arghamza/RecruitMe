import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_type_screen/chat/MessagesWidgets/message_bubble.dart';
import 'package:user_type_screen/chat/Models/conversation_model.dart';
import 'package:user_type_screen/chat/Models/message_model.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream(
      {Key? key,
      required this.isRecruiter,
      required this.firestore,
      required this.conversationModel,
      required this.loggedInUserEmail})
      : super(key: key);

  final FirebaseFirestore firestore;
  final ConversationModel conversationModel;
  final String loggedInUserEmail;
  final bool isRecruiter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('chats')
          .doc(conversationModel.id)
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
          final MessageModel messageModel = MessageModel(
            senderId: message.get('sender'),
            text: message.get('text'),
            dateServer: message.get('dateServer'),
            dateUser: message.get('dateServer'),
          );

          final messageBubble = MessageBubble(
              messageModel: messageModel,
              isMe: loggedInUserEmail == messageModel.senderId);

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
