// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, use_key_in_widget_constructors

import 'package:drone_for_smart_farming/Screen/mapScreen.dart';
import 'package:drone_for_smart_farming/Widget/searchDialog.dart';
import 'package:drone_for_smart_farming/service/locationController.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:drone_for_smart_farming/Screen/homescreendroneowner.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  late CameraPosition kGooglePlex;

  late Position userLocation;

  List<Marker> myMarker = [];
  late LatLng point = LatLng(userLocation.latitude, userLocation.longitude);
  String _currentAddress = '';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //get current location from user
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

  //add marker on google map
  void _onAddMarkerButtonPressed(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
      _getAddress();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('${_currentAddress}  '),
          );
        },
      );
    });
    point = LatLng(tappedPoint.latitude, tappedPoint.longitude);
  }

  //translate latlong to readable address
  _getAddress() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(point.latitude, point.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country} \n lat: ${point.latitude}, \n long:${point.longitude}";
      });
    } catch (e) {
      CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9FE2BF),
        title: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            height: 40,
            width: 40,
            child: FloatingActionButton(
              heroTag: 1,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreenDroneOwner()));
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ]),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FutureBuilder(
              future: _getLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                      mapType: MapType.hybrid,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              userLocation.latitude, userLocation.longitude),
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
            Positioned(
              top: 20,
              left: 30,
              right: 60,
              child: InkWell(
                onTap: () {
                  Get.dialog(
                      LocationSearchDialog(mapController: mapController));
                },
                child: Container(
                  height: 60,
                  width: 250,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),

            //save location
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 60,
                width: 280,
                child: ElevatedButton(
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff2f574b),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
