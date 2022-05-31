import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/admin/admin_screen.dart';
import 'package:user_type_screen/constants.dart';
import 'package:user_type_screen/model/offre_model.dart';
import 'package:user_type_screen/widget/my_offers_banner.dart';
import 'package:user_type_screen/widget/project_app_bar.dart';

import '../widget/offer_details.dart';

class AdminOffers extends StatefulWidget {
  AdminOffers({Key? key}) : super(key: key);
  List<OffreModel> offers = [];

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

  bool _isShown = true;

  void _delete(BuildContext context, String offerId) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the box?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isShown = false;
                    });
                    FirebaseFirestore.instance
                        .collection("offres")
                        .doc(offerId)
                        .delete();
                    // Close the dialog
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminScreen()));
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

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
                    itemCount: widget.offers.length,
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
                                  text: widget.offers[index].titre!,
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
                                          offer: widget.offers[index],
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: _isShown == true
                                            ? () => _delete(context,
                                                widget.offers[index].offerId!)
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
          widget.offers.add(model);
        });
      }
    });
  }
}
