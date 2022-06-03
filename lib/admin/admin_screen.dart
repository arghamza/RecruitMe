import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_type_screen/admin/admin_offers.dart';
import 'package:user_type_screen/admin/admin_users.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int currentindextap = 0;
  void onTap(int index) {
    setState(() {
      currentindextap = index;
    });
  }

  List pages = [
    const AdminOffers(),
    const AdminUsers(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Container(
          child: Flexible(
              child: Image.asset('images/logofondblanccropped.png',
                  fit: BoxFit.fill)),
          padding: const EdgeInsets.only(top: 20.0),
        ),
      ),
      body: pages[currentindextap],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        currentIndex: currentindextap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(
              label: "Offers",
              icon: Icon(FontAwesomeIcons.suitcase),
              activeIcon: Icon(
                FontAwesomeIcons.suitcase,
                color: Color(0xff35ddaa),
              )),
          BottomNavigationBarItem(
              label: "Users",
              icon: Icon(Icons.person),
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff35ddaa),
              )),
        ],
        onTap: onTap,
      ),
    );
  }
}
