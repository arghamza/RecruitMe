import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Recruiter/creationoffre_screen.dart';

class MyOffersBanner extends StatelessWidget {
  const MyOffersBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12.0, left: 5.0),
          child: Text("Mes offres",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              )),
        ),
        GestureDetector(
          onTap: (() {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CreationOffre()));
          }),
          child: Container(
            margin: const EdgeInsets.only(top: 20.0, left: 15.0),
            child: const Icon(
              Icons.add_comment_outlined,
              color: Color(0xff35ddaa),
              size: 45,
            ),
          ),
        )
      ],
    );
  }
}
