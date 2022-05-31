import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/constants.dart';

import '../model/offre_model.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({
    Key? key,
    required this.offer,
  }) : super(key: key);

  final OffreModel offer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: 'Entreprise:   ',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Color(0xff35ddaa), letterSpacing: .5, fontSize: 15),
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: offer.entreprise,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 13),
                fontWeight: FontWeight.w300),
          ),
        ])),
        const SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: 'Poste:   ',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Color(0xff35ddaa), letterSpacing: .5, fontSize: 15),
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: offer.poste,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 13),
                fontWeight: FontWeight.w300),
          ),
        ])),
        const SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: 'Domaine:   ',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Color(0xff35ddaa), letterSpacing: .5, fontSize: 15),
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: offer.domaine,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 13),
                fontWeight: FontWeight.w300),
          ),
        ])),
        const SizedBox(
          height: 20,
        ),
        Text(
          'A propos de l\'offre:',
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  color: Color(0xff35ddaa), letterSpacing: .5, fontSize: 15),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width - 110,
            height: MediaQuery.of(context).size.height - 750,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                offer.details!,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black, letterSpacing: .5, fontSize: 13),
                    fontWeight: FontWeight.w300),
              ),
            )),
          ),
        )
      ],
    );
  }
}
