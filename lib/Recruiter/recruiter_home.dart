// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_type_screen/Recruiter/creationoffre_screen.dart';

class RecruiterHome extends StatefulWidget {
  const RecruiterHome({Key? key}) : super(key: key);

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreationOffre()));
      }),
      child: Container(
        margin: EdgeInsets.only(top: 700, left: 340),
        child: Icon(
          Icons.add_comment_outlined,
          color: const Color(0xff35ddaa),
          size: 40,
        ),
      ),
    );
  }
}
