import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/admin/admin_screen.dart';
import 'package:user_type_screen/model/offre_model.dart';
import 'package:user_type_screen/widget/my_offers_banner.dart';

import '../widget/delete_dialog.dart';
import '../widget/offer_details.dart';

class AdminOffers extends StatefulWidget {
  const AdminOffers({Key? key}) : super(key: key);

  @override
  State<AdminOffers> createState() => _AdminOffersState();
}

class _AdminOffersState extends State<AdminOffers> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  List<OffreModel> offers = [];
  bool _isShown = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const MyOffersBanner(),
              const SizedBox(height: 50),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: offers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: Column(
                          children: [
                            ExpandablePanel(
                              header: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'Titre de l\'offre:   ',
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: 17),
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: offers[index].titre!,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: 15),
                                      fontWeight: FontWeight.w300),
                                ),
                              ])),
                              collapsed: Container(),
                              expanded: Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 330,
                                      child: Center(
                                        child: OfferDetails(
                                          offer: offers[index],
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: _isShown == true
                                            ? () => {
                                                  setState(() {
                                                    _isShown = false;
                                                  }),
                                                  deleteWidget(
                                                      context,
                                                      offers[index].offerId!,
                                                      "offres",
                                                      const AdminScreen(),
                                                      'Vous êtes sûr de vouloir effacer cette offre?',
                                                      _isShown)
                                                }
                                            : null,
                                        child: const Icon(
                                          FontAwesomeIcons.trashCan,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    // Get docs from collection reference
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("offres").get().then((value) {
      for (var element in List.from(value.docs)) {
        OffreModel model = OffreModel.fromMap(element);
        setState(() {
          offers.add(model);
        });
      }
    });
  }
}
