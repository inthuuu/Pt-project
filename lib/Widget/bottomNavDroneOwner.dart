// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:drone_for_smart_farming/Screen/droneList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screen/homeScreenDroneOwner.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class BottomNavigationBarDroneProvider with ChangeNotifier {
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
    DroneList(),
    HomeScreenDroneOwner()
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarDroneProvider>(context);
    return Scaffold(
      extendBody: true,
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: provider.currentIndex,
          //_SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: (index) {
            setState(() {
              provider.currentIndex = index;
            });
          },
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Color(0xff2f574b),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.menu),
              selectedColor: Color(0xff2f574b),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.chat_rounded),
              selectedColor: Color(0xff2f574b),
            ),
          ],
        ),
      ),
    );
  }
}

