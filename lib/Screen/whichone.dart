import 'package:drone_for_smart_farming/Screen/homescreendroneowner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:drone_for_smart_farming/Screen/homescreenframer.dart';

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
                          builder: (context) => HomeScreenFarmer()));
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
                          builder: (context) => HomeScreenDroneOwner()));
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
            Container(
              child: Text("เกษตรกร",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
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
