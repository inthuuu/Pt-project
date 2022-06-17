import 'package:drone_for_smart_farming/login.dart';
// ignore_for_file: prefer_const_constructors

import 'package:drone_for_smart_farming/drawPolygon.dart';
import 'package:drone_for_smart_farming/map.dart';
import 'package:drone_for_smart_farming/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen());
  }
}
