// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
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
    HomeScreenDroneOwner(),
    HomeScreenDroneOwner()
  ];
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

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
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Color(0xff2f574b),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite),
              selectedColor: Color(0xff2f574b),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
              selectedColor: Color(0xff2f574b),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Color(0xff2f574b),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { home, favorite, search, person }
