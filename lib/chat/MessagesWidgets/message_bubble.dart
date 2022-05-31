import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_type_screen/chat/Models/message_model.dart';

import '../../constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.isMe,
      required this.messageModel,
      required this.interlocutorAvatar})
      : super(key: key);

  final MessageModel messageModel;
  final CircleAvatar interlocutorAvatar;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(right: 10.0, top: 12.0),
                  child: interlocutorAvatar),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 3.0),
                child: Text(
                  DateFormat('d/M/y H:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          messageModel.dateServer.millisecondsSinceEpoch)),
                  style: const TextStyle(
                    fontSize: 8.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              Material(
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                elevation: 5.0,
                color: isMe ? kAppColorTheme : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    messageModel.text,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: isMe ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
