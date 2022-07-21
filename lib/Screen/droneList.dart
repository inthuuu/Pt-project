// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import '../Widget/bottomNavDroneOwner.dart';

class DroneList extends StatefulWidget {
  const DroneList({Key? key}) : super(key: key);

  @override
  State<DroneList> createState() => _DroneListState();
}

class _DroneListState extends State<DroneList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      appBar: AppBar(
        backgroundColor: Color(0xFF9FE2BF),
        elevation: 0,
        title: Row(children: [
          Container(
            alignment: Alignment.topLeft,
            height: 40,
            width: 40,
            child: FloatingActionButton(
              heroTag: 1,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationDroneOwner()));
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 80,
          ),
          Text(
            "รายการโดรน",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 40,
          ),
          SizedBox(
            height: 40,
            width: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              child: Text(
                "แก้ไข",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => EditProfileDroneOwner()));
              },
            ),
          )
        ]),
      ),
      body: Column(children: []),
    );
  }
}
