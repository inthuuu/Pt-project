import 'package:drone_for_smart_farming/drawPolygon.dart';
import 'package:drone_for_smart_farming/map.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drone_for_smart_farming/login.dart';
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
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "บริการโดรน",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "บริการโดรนเพื่อการเกษตร",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 80,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF30574B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Container(
                  child: Text("เลือกบริการ",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                onPressed: () async {
                  setState(() {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => PolygonScreen()));
                  });
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("กิจกรรม",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Divider(color: Colors.black,)
          ],
        ),
      ),
    );
  }
}