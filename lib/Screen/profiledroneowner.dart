import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:drone_for_smart_farming/Screen/editprofiledroneowner.dart';

import '../Widget/bottomNavDroneOwner.dart';

class ProfileDroneOwner extends StatefulWidget {
  const ProfileDroneOwner({Key? key}) : super(key: key);

  @override
  State<ProfileDroneOwner> createState() => _ProfileDroneOwnerState();
}

class _ProfileDroneOwnerState extends State<ProfileDroneOwner> {
  final _auth = FirebaseAuth.instance;

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
            width: 30,
          ),
          Text(
            "บัญชีผู้ใช้",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 130,
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileDroneOwner()));
              },
            ),
          )
        ]),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "ชื่อ",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "a name",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "เบอร์โทร",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "091-999-9999",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "ที่อยู่",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: 250,
        ),
        SizedBox(
          height: 55,
          width: 350,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Text("ออกจากระบบ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ),
      ]),
    );
  }
}
