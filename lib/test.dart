// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  double long = 49.5;
  double lat = -0.09;
  dynamic point = LatLng(49.5, -0.09);
  var location = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Display map
        FlutterMap(
          options: MapOptions(
              onTap: ((tapPosition, p) async {
                // location = await Geocoder.local.findAddressesFromCoordinates(
                //     new Coordinates(p.latitude, p.longitude));

                setState(
                  () {
                    point = p;
                  },
                );
              }),
              center: LatLng(49.5, -0.09),
              zoom:
                  5.0), //will allow us to position the center of the map at a certain coordinate
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              // attributionBuilder: (_) {
              //   return Text("© OpenStreetMap contributors");
              // },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                    width: 100.0,
                    height: 100.0,
                    point: point,
                    builder: (ctx) => Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 60.0,
                        )),
              ],
            ),
          ],
        ),
        //Searching box
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Search for location",
                      contentPadding: EdgeInsets.all(16.0)),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [Text("")],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
