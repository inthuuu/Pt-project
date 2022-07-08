// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Screen/homeScreenDroneOwner.dart';

class BottomNavigationBarProvider2 with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class BottomNavigationDroneOwner extends StatefulWidget {
  const BottomNavigationDroneOwner({Key? key}) : super(key: key);

  @override
  State<BottomNavigationDroneOwner> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationDroneOwner> {
  List<Widget> currentTab = [
    HomeScreenDroneOwner(),
    HomeScreenDroneOwner(),
    HomeScreenDroneOwner()
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider2>(context);
    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey.shade800,
              hoverColor: Colors.grey.shade700,
              gap: 8,
              tabActiveBorder: Border.all(color: Colors.black, width: 1),
              activeColor: Color(0xff2f574b),
              iconSize: 36,
              tabBackgroundColor: Color(0xff2f574b).withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tabs: [
                GButton(
                  icon: Icons.home_sharp,
                  text: 'หน้าหลัก',
                ),
                GButton(
                  icon: Icons.add_box_rounded,
                  text: 'เลือกบริการ',
                ),
                GButton(
                  icon: Icons.chat_rounded,
                  text: 'ข้อความ',
                )
              ],
              selectedIndex: provider.currentIndex,
              onTabChange: (index) {
                setState(() {
                  provider.currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
