import 'package:drone_for_smart_farming/Widget/bottomNavDroneOwner.dart';
import 'package:flutter/material.dart';
import '../Widget/bottomNav.dart';
import '../Widget/checkbox.dart';

class AddDrone extends StatefulWidget {
  const AddDrone({Key? key}) : super(key: key);

  @override
  State<AddDrone> createState() => _AddDroneState();
}

class _AddDroneState extends State<AddDrone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                height: 40,
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
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'เลือกบริการ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                  child: ServiceState()),
              SizedBox(height: 30),
            ],
          ),
        )),
      ),
    );
  }
}
