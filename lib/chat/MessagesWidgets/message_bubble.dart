import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_type_screen/chat/Models/message_model.dart';

import '../../constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, required this.isMe, required this.messageModel})
      : super(key: key);

  final MessageModel messageModel;
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
            DateFormat('d/M/y hh:mm').format(
                DateTime.fromMillisecondsSinceEpoch(
                    messageModel.date.millisecondsSinceEpoch)),
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
    );
  }
}
