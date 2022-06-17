// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;

  late CameraPosition kGooglePlex;

  List<Marker> myMarker = [];

  // late final Set<Marker> _markers = {
  //   Marker(
  //       markerId: MarkerId("id"),
  //       icon: BitmapDescriptor.defaultMarker,
  //       position: LatLng(userLocation.latitude, userLocation.longitude),
  //       onTap: () {})
  // };

  late LatLng point = LatLng(userLocation.latitude, userLocation.longitude);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return userLocation;
  }

  void _onAddMarkerButtonPressed(LatLng tappedPoint) {
    myMarker = [];
    setState(() {
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
                mapType: MapType.hybrid,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15),
                markers: Set.from(myMarker),
                onTap: _onAddMarkerButtonPressed);
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(userLocation.latitude, userLocation.longitude), 18));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'Your location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude} '),
              );
            },
          );
        },
        label: Text("Send Location"),
        icon: Icon(Icons.near_me),
      ),
    );
  }
}
