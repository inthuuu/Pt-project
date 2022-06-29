// ignore_for_file: avoid_print, prefer_final_fields, file_names

import 'dart:convert';

import 'package:drone_for_smart_farming/service/locationData.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';

class LocationController extends GetxController {
  static Placemark _placemark = Placemark();
  static Placemark get placemark => _placemark;

  late List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("my status is " + data['status']);
      if (data['status' == 'OK']) {
        _predictionList = [];
        data['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        //ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
}
