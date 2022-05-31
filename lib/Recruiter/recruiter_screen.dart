// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:user_type_screen/Recruiter/recruiter_home.dart';
import 'package:user_type_screen/widget/settings.dart';

import '../chat/chat_list.dart';
import '../widget/project_app_bar.dart';

class Recruiter extends StatefulWidget {
  const Recruiter({Key? key}) : super(key: key);

  @override
  State<Recruiter> createState() => _RecruiterState();
}

class _RecruiterState extends State<Recruiter> {
  int currentindextap = 0;
  void onTap(int index) {
    setState(() {
      currentindextap = index;
    });
  }

  //List Bottom Navigator Pages
  List pages = [
    RecruiterHome(),
    ConversationsList(
      accountType: 'recruiter',
    ),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(),
      body: pages[currentindextap],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        currentIndex: currentindextap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Image.asset("images/me.png"),
              activeIcon: Image.asset("images/minilogofondblanc.png")),
          BottomNavigationBarItem(
              label: "Message",
              icon: Icon(Icons.message),
              activeIcon: Icon(
                Icons.message,
                color: const Color(0xff35ddaa),
              )),
          BottomNavigationBarItem(
              label: "My page",
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings, color: const Color(0xff35ddaa))),
        ],
        onTap: onTap,
      ),
    );
  }
}
