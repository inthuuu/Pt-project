// ignore_for_file: prefer_const_constructors

import 'package:drone_for_smart_farming/service/locationController.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialog({required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 150),
      padding: const EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
            width: 350,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      hintText: 'ค้นหา',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0)),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).disabledColor),
                      filled: true,
                      fillColor: Theme.of(context).cardColor),
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: 16)),
              itemBuilder: (BuildContext context, Prediction suggestion) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Icon(Icons.location_on),
                    Expanded(child: Text(suggestion.description!))
                  ]),
                );
              },
              onSuggestionSelected: (Prediction suggestion) {
                print("My location is " + suggestion.description!);
              },
              suggestionsCallback: (String pattern) async {
                return await Get.find<LocationController>()
                    .searchLocation(context, pattern);
              },
            )),
      ),
    );
  }
}
