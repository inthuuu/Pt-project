import 'package:flutter/cupertino.dart';

import '../model/Service.dart';

class ManageService with ChangeNotifier {
  List<Service> services = [
    Service(name: 'name'),
    Service(name: 'name'),
    Service(name: 'name'),
  ];

  List<Service> getService() {
    return services;
  }
}
