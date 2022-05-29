import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({
    Key? key,
    required this.titre,
    required this.entreprise,
    required this.poste,
    required this.domaine,
    required this.details,
  }) : super(key: key);

  final String titre;
  final String entreprise;
  final String poste;
  final String domaine;
  final String details;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Container(
        height: 30,
        margin: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
          Icon(Icons.edit, size: 25, color: Colors.black),
          Icon(Icons.delete, size: 25, color: Colors.black),
        ]),
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Text(
                titre,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black, letterSpacing: .5, fontSize: 25),
                    fontWeight: FontWeight.w600),
              ),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Entreprise:  ',
                style: kFormsTextFont,
              ),
              TextSpan(
                text: entreprise,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black, letterSpacing: .5, fontSize: 15),
                    fontWeight: FontWeight.w300),
              ),
            ])),
            const SizedBox(
              height: 12,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Poste:  ',
                style: kFormsTextFont,
              ),
              TextSpan(
                text: poste,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black, letterSpacing: .5, fontSize: 15),
                    fontWeight: FontWeight.w300),
              ),
            ])),
            const SizedBox(
              height: 12,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Domaine:  ',
                style: kFormsTextFont,
              ),
              TextSpan(
                text: domaine,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black, letterSpacing: .5, fontSize: 15),
                    fontWeight: FontWeight.w300),
              ),
            ])),
            const SizedBox(
              height: 12,
            ),
            Text(
              'A propos de l\'offre:',
              style: kFormsTextFont,
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              width: 200,
              height: 230,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  details,
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 10),
                      fontWeight: FontWeight.w300),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
