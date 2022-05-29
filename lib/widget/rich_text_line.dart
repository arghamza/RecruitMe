import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/user_model.dart';

class RichTextLine extends StatelessWidget {
  const RichTextLine({
    Key? key,
    required this.applicant,
    required this.title,
  }) : super(key: key);

  final UserModel? applicant;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: title,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 20),
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: '${applicant?.email}',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 18),
                fontWeight: FontWeight.w300),
          ),
        ]));
  }
}
