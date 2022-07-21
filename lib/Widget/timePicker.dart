// ignore_for_file: camel_case_types, unnecessary_null_comparison, file_names, prefer_const_constructors, deprecated_member_use, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';

class timePicker extends StatefulWidget {
  const timePicker({Key? key}) : super(key: key);

  @override
  State<timePicker> createState() => _timePickerState();
}

class _timePickerState extends State<timePicker> {
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
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
                initialTime: time)
            .then((_time) => setState(() {
                  time = _time!;
                }));
      },
      child: Text(
        time == null
            ? 'เลือกเวลาทีต้องการใช้บริการ'
            : '${time.hour.toString()} : ${time.minute.toString()}',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
