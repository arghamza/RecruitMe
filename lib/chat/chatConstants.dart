import 'package:flutter/material.dart';
import 'package:user_type_screen/constants.dart';

const kSendButtonTextStyle = TextStyle(
  color: Color(0xff35ddaa),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0xff35ddaa), width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff35ddaa), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff35ddaa), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

//await _fireStore
//       .collection('chats')
//       .doc('fatima@gmail.com+hamza@gmail.com')
//       .get()
//       .then((value) => chats.add(value.data()));
// }
