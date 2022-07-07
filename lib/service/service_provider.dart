import 'package:flutter/cupertino.dart';
import '../model/Service.dart';

class ManageService with ChangeNotifier {
  List<Service> services = [
    Service(name: 'รดน้ำ ให้ฮอร์โมน'),
    Service(name: 'ถ่ายภาพวิเคราะห์/ตรวจโรคพืช'),
    Service(name: 'หว่านปุ๋ย และฉีดพ่นสารเคมีกำจัดแมลงศัตรูพืช'),
  ];

  bool isFirstTime = false;

  List<Service> getService() {
    return services;
  }
}
