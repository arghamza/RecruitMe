import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:user_type_screen/constants.dart';
import 'package:user_type_screen/model/offre_model.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);
  List offers = [];

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('offres');
    getData(_collectionRef);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Offres",
            style: kFormsTextFont,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ExpandablePanel(
                    header: Text("Offer " + index.toString()),
                    collapsed: Text('Collapse'),
                    expanded: Text('Expanded'),
                  );
                }),
          ),
          Text(
            "Offres",
            style: kFormsTextFont,
          ),
        ],
      ),
    );
  }

  Future<void> getData(CollectionReference _collectionRef) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    widget.offers = querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
