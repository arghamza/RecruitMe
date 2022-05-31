import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_type_screen/chat/ConversationsWidgets/conversations_box.dart';
import 'package:user_type_screen/chat/Models/conversation_model.dart';

class ConversationsController {
  Widget generateListConversations({
    required BuildContext context,
    required FirebaseFirestore fireStore,
    required String loggedInUserEmail,
    required bool isRecruiter,
  }) {
    final fieldToCheck = isRecruiter ? 'user1' : 'user2';

    return StreamBuilder<QuerySnapshot>(
      stream: fireStore
          .collection('chats')
          .where(fieldToCheck, isEqualTo: loggedInUserEmail)
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
          final conversationModel = ConversationModel(
            id: conversation.id,
            applicantId: conversation.get('user2'),
            applicantFullName: conversation.get('user2FullName'),
            applicantImg: conversation.get('user2Img'),
            recruiterId: conversation.get('user1'),
            recruiterFullName: conversation.get('user1FullName'),
            recruiterImg: conversation.get('user1Img'),
            lastText: conversation.get('lastText'),
          );
          final messageBubble = ConversationBox(
            loggedInUserEmail: loggedInUserEmail,
            conversationModel: conversationModel,
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
