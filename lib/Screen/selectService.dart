import 'package:drone_for_smart_farming/Screen/drawPolygon.dart';
import 'package:drone_for_smart_farming/Widget/calendar.dart';
import 'package:drone_for_smart_farming/Widget/checkbox.dart';
import 'package:flutter/material.dart';
import '../Widget/bottomNav.dart';
import '../Widget/timePicker.dart';

class SelectService extends StatefulWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
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
                            builder: (context) => BottomNavigation()));
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
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'เมื่อใด',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'วันที่',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 8,
                    child: Container(
                        height: 50,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Calendar(),
                        ))),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'เวลา',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 8,
                    child: Container(
                        height: 50,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: timePicker(),
                        ))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      height: 60,
                      width: 280,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PolygonScreen()));
                        },
                        child: Text(
                          'ถัดไป',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff2f574b),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
