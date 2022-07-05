// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison, prefer_const_constructors
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
                context: context,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Color(0xff2f574b), // <-- SEE HERE
                        onPrimary: Colors.white, // <-- SEE HERE
                        onSurface: Colors.black, // <-- SEE HERE
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: Color(0xff2f574b), // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 0)),
                lastDate: DateTime(2222))
            .then((date) => {
                  setState(() {
                    _dateTime = date!;
                  })
                });
      },
      child: Text(
        _dateTime == null
            ? 'Nothing has been picked yet'
            : ' วันที่ ${_dateTime.day.toString()} เดือน ${_dateTime.month.toString()} ปี ${_dateTime.year.toString()}',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
