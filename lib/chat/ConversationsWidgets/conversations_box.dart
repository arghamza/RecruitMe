import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                    interlocutorImgURL:
                        loggedInUserEmail == conversationModel.recruiterId
                            ? conversationModel.applicantImg
                            : conversationModel.recruiterImg,
                    conversationModel: conversationModel,
                    isRecruiter:
                        loggedInUserEmail == conversationModel.recruiterId),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        minRadius: 10.0,
                        maxRadius: 22.0,
                        backgroundImage: NetworkImage(
                            loggedInUserEmail == conversationModel.recruiterId
                                ? conversationModel.applicantImg
                                : conversationModel.recruiterImg),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                                loggedInUserEmail ==
                                        conversationModel.applicantId
                                    ? conversationModel.recruiterFullName
                                    : conversationModel.applicantFullName,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500))),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            conversationModel.lastText,
                            style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    conversationModel.lastTextDate.millisecondsSinceEpoch)),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
