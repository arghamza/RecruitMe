import 'package:flutter/material.dart';

import '../Models/conversation_model.dart';
import '../chat_screen.dart';

class ConversationBox extends StatelessWidget {
  const ConversationBox({
    Key? key,
    required this.conversationModel,
    required this.loggedInUserEmail,
  }) : super(key: key);
  final String loggedInUserEmail;
  final ConversationModel conversationModel;

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
                      conversationModel: conversationModel,
                      isRecruiter:
                          loggedInUserEmail == conversationModel.recruiterId),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8.0, bottom: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 4.0, right: 10.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(loggedInUserEmail ==
                                    conversationModel.recruiterId
                                ? conversationModel.applicantImg
                                : conversationModel.recruiterImg),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  loggedInUserEmail ==
                                          conversationModel.applicantId
                                      ? conversationModel.recruiterFullName
                                      : conversationModel.applicantFullName,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                conversationModel.lastText,
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 13.0),
                              ),
                            ],
                          ),
                        )
                      ],
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
