import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar chatAppBar(BuildContext context, String interlocutorImgURL,
    String interlocutorFullName) {
  return AppBar(
    toolbarHeight: MediaQuery.of(context).size.height * 0.12,
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Color(0xff35ddaa), //change your color here
    ),
    backgroundColor: Colors.white,
    actions: <Widget>[
      IconButton(icon: const Icon(FontAwesomeIcons.phone), onPressed: () {}),
      Container(
        margin: const EdgeInsets.only(right: 5.0),
        child: IconButton(
            icon: const Icon(FontAwesomeIcons.video), onPressed: () {}),
      ),
    ],
    title: Column(
      children: [
        CircleAvatar(
          minRadius: 12.0,
          maxRadius: 22.0,
          backgroundImage: NetworkImage(
            interlocutorImgURL,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            interlocutorFullName,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300)),
          ),
        ),
      ],
    ),
  );
}
