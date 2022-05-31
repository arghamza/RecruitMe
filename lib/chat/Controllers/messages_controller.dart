import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MessagesController {
  User? getCurrentUser(FirebaseAuth auth) {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
