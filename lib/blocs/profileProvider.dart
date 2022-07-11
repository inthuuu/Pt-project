// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  var name;
  var phone;
  var address;
  var area;

  bool isFirstTime = true;

  void setIsFirstTime() {
    isFirstTime = false;
    notifyListeners();
  }

  void getProfile(var name, var phone, var address, var area) {
    this.name = name;
    this.phone = phone;
    this.address = address;
    this.area = area;
    notifyListeners();
  }
}
