import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Recruiter/recruiter_screen.dart';
import 'package:user_type_screen/model/offre_model.dart';

import '../constants.dart';
import 'delete_dialog.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({
    Key? key,
    required this.offer,
  }) : super(key: key);

  final OffreModel offer;

  @override
  Widget build(BuildContext context) {
    bool _isShown = true;
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Container(
        height: 30,
        margin: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
              onPressed: () {},
              child: const Icon(Icons.edit, size: 25, color: Colors.black)),
          TextButton(
              onPressed: _isShown == true
                  ? () => {
                        deleteWidget(
                            context,
                            offer.offerId!,
                            "offres",
                            const Recruiter(),
                            'Vous êtes sûr de vouloir effacer cette offre?',
                            _isShown)
                      }
                  : null,
              child: const Icon(Icons.delete, size: 25, color: Colors.black)),
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
                offer.titre!,
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
                text: offer.entreprise,
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
                text: offer.poste,
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
                text: offer.domaine,
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
                  offer.details!,
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
