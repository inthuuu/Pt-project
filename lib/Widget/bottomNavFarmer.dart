// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:drone_for_smart_farming/Screen/homeScreenFarmer.dart';

class BottomNavigationBarFarmerProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class BottomNavigationFarmer extends StatefulWidget {
  const BottomNavigationFarmer({Key? key}) : super(key: key);

  @override
  State<BottomNavigationFarmer> createState() => _BottomNavigationFarmerState();
}

class _BottomNavigationFarmerState extends State<BottomNavigationFarmer> {
  List<Widget> currentTab = [
    HomeScreenFarmer(),
    HomeScreenFarmer(),
    HomeScreenFarmer()
  ];
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarFarmerProvider>(context);
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
