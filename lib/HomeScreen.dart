// ignore_for_file: prefer_const_constructors, file_names, unnecessary_null_comparison

import 'package:drone_for_smart_farming/drawPolygon.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //await _auth.signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PolygonScreen()));
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
