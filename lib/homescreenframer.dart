// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:drone_for_smart_farming/drawPolygon.dart';
import 'package:flutter/material.dart';
import 'package:drone_for_smart_farming/profilefarmer.dart';

class HomeScreenFarmer extends StatefulWidget {
  const HomeScreenFarmer({Key? key}) : super(key: key);

  @override
  State<HomeScreenFarmer> createState() => _HomeScreenFarmerState();
}

class _HomeScreenFarmerState extends State<HomeScreenFarmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ProfileFarmer()));
                },
                child: Icon(Icons.account_circle_rounded),
              )),
        ],
        actionsIconTheme: IconThemeData(size: 50.0, color: Colors.black),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "บริการโดรน",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "บริการโดรนเพื่อการเกษตร",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 70,
              width: 350,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                icon: Icon(
                  Icons.accessibility_new_rounded,
                  color: Colors.black,
                ),
                label: Text("เลือกบริการ",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onPressed: () async {
                  setState(() {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PolygonScreen()));
                  });
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text("กิจกรรม",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            Divider(color: Colors.black)
          ],
        ),
      ),
    );
  }
}
