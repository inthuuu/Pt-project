// ignore_for_file: prefer_const_constructors

import 'package:drone_for_smart_farming/Screen/profilefarmer.dart';
import 'package:flutter/material.dart';
import 'homescreenframer.dart';

class EditProfileFarmer extends StatefulWidget {
  const EditProfileFarmer({Key? key}) : super(key: key);

  @override
  State<EditProfileFarmer> createState() => _EditProfileFarmerState();
}

class _EditProfileFarmerState extends State<EditProfileFarmer> {
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileFarmer()));
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
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              "บัญชีผู้ใช้",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
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
          SizedBox(
            height: 55,
            width: 350,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter a product name eg. pension',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Colors.white,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
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
          SizedBox(
            height: 55,
            width: 350,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter a product name eg. pension',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Colors.white,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
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
          SizedBox(
            height: 55,
            width: 350,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter a product name eg. pension',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Colors.white,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "พื้นที่",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // Container(
          //   child:,
          // ),
          SizedBox(
            height: 55,
            width: 350,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff2f574b),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child: Text("ตกลง",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileFarmer()));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
