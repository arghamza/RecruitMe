import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recruitme/Login/home.dart';
import 'package:recruitme/Login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAnYYkiSwWaaZvTNRm9gkzchcp3FmmGg70",
      appId: "1:775736873350:android:85c76bee3d9d0c72895c07",
      messagingSenderId: "775736873350",
      projectId: "recruitme-aeb0f",
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
      home: const HomeScreen(),
    );
  }
}
