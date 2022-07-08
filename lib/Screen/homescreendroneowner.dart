// ignore_for_file: prefer_const_constructors
import 'package:drone_for_smart_farming/Screen/addDrone.dart';
import 'package:flutter/material.dart';
import 'package:drone_for_smart_farming/Screen/profileDroneOwner.dart';

class HomeScreenDroneOwner extends StatefulWidget {
  const HomeScreenDroneOwner({Key? key}) : super(key: key);

  @override
  State<HomeScreenDroneOwner> createState() => _HomeScreenDroneOwnerState();
}

class _HomeScreenDroneOwnerState extends State<HomeScreenDroneOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDroneOwner()));
                },
                child: Icon(Icons.account_circle_rounded),
              )),
        ],
        actionsIconTheme: IconThemeData(size: 50.0, color: Colors.black),
        title: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "บริการโดรน",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "บริการโดรนเพื่อการเกษตร",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                  label: Text("เลือกบริการที่ต้องการให้บริการ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () async {
                    setState(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AddDrone()));
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
      ),
    );
  }
}
