// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_type_screen/Recruiter/recruiter_main_screen.dart';
import '../model/offre_model.dart';
import '../widget/my_offers_banner.dart';
import '../widget/offers_card.dart';

class RecruiterHome extends StatefulWidget {
  const RecruiterHome({Key? key}) : super(key: key);

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {
  List<OffreModel> offers = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  void initState() {
    FirebaseAuth user = FirebaseAuth.instance;
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      firebaseFirestore
          .collection("users")
          .doc(user.currentUser?.uid)
          .get()
          .then((value) {
        for (var element in List.from(value.data()!['offres'])) {
          OffreModel model = OffreModel.fromMap(element);
          setState(() {
            offers.add(model);
          });
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    OffersCard makeListTile(OffreModel offer) => OffersCard(
          offer: offer,
        );

    Card makeCard(OffreModel offer) => Card(
          elevation: 10.0,
          color: Color.fromARGB(255, 190, 244, 227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: makeListTile(offer),
        );
    final OffersList = SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: offers.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecruiterMainScreen(
                          offerId: offers[index].offerId,
                        )));
              },
              child: Expanded(
                child: Column(
                  children: [
                    Column(
                      children: [
                        MyOffersBanner(),
                        makeCard(offers[index]),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return GestureDetector(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 5), () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecruiterMainScreen(
                              offerId: offers[index].offerId,
                            )));
                  });
                },
                child: makeCard(offers[index]));
          }
        },
      ),
    );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: offers.isEmpty ? MyOffersBanner() : OffersList,
          ),
        ));
  }

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
