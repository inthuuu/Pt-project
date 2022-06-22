import 'package:drone_for_smart_farming/service/geolocator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Applicationbloc with ChangeNotifier {
  final geolocatorService = GeolocatorSeries();

  //Variables
  Position? currentLocation;

  Applicationbloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }
}
