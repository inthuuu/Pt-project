import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  var name;
  var phone;
  var address;
  var area;

  void getProfile(var name, var phone, var address, var area) {
    this.name = name;
    this.phone = phone;
    this.address = address;
    this.area = area;
    notifyListeners();
  }
}
