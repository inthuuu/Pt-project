// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import '../Widget/bottomNavDroneOwner.dart';
import '../Widget/bottomNavFarmer.dart';

class whichone extends StatefulWidget {
  const whichone({Key? key}) : super(key: key);

  @override
  State<whichone> createState() => _whichoneState();
}

class _whichoneState extends State<whichone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      body: Column(children: [
        Spacer(),
        Container(
          alignment: Alignment.bottomCenter,
          child: Text("คุณเป็นใคร ?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationFarmer()));
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset('image/farmer.jpg', width: 110, height: 110),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationDroneOwner()));
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child:
                    Image.asset('image/drone.jpg', width: 110.0, height: 110.0),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            Text("เกษตรกร",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              width: 85,
            ),
            Container(
              child: Text("เจ้าของโดรน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Spacer(),
      ]),
    );
  }
}
