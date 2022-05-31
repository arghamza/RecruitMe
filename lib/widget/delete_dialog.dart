import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void deleteWidget(BuildContext context, String userId, String collection,
    Widget redirect, String message, bool _isShown) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirmer'),
          content: Text(message),
          actions: [
            // The "Yes" button
            TextButton(
                onPressed: () {
                  // Remove the box

                  FirebaseFirestore.instance
                      .collection(collection)
                      .doc(userId)
                      .delete();
                  // Close the dialog
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => redirect));
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
