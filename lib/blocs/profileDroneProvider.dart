// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

class ProfileDroneProvider with ChangeNotifier {
  var name;
  var phone;
  var address;

  bool isFirstTime = true;

  void setIsFirstTime(bool booleanChange) {
    //booleanChange = false;
    isFirstTime = booleanChange;
    // isFirstTime = false;
    // notifyListeners();
  }

  void getProfile(var name, var phone, var address) {
    this.name = name;
    this.phone = phone;
    this.address = address;
    notifyListeners();
  }
}
