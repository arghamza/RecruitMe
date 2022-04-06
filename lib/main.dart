import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recruitme/Login/home.dart';
import 'package:recruitme/Login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:
          "AAAAaRLoCKY:APA91bFumvQZMxJx_fX7okZH3Az4YHvnSLMc0TK-Jv0WDrEzJDGT1839IsycGoZKRFW9xdWz8p4z8M7Qx1DnH-Zymn_1uPJQPWGa9OTyDoa3OxMuyQFH9Xw9LTwR3P4gFCknwqD0g92L",
      appId: "1:451288762534:android:c3f9d56e55e2e631e88c67",
      messagingSenderId: "451288762534",
      projectId: "recruitme-2760e",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(),
    );
  }
}
