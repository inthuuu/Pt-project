import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  late GoogleMapController mapController;
  late CameraPosition kGooglePlex;

  late Position userLocation;

  List<Marker> myMarker = [];
  late LatLng point = LatLng(userLocation.latitude, userLocation.longitude);

  Set<Polygon> _polygone = HashSet<Polygon>();
  List<LatLng> points = [];

  late double radius;

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
      //myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
    point = LatLng(tappedPoint.latitude, tappedPoint.longitude);
    points.add(point);

    setState(() {
      _setPolygon();
    });
  }

  //draw polygon on google map
  void _setPolygon() {
    _polygone.add(Polygon(
        polygonId: PolygonId('1'),
        points: points,
        strokeColor: Colors.deepPurple,
        strokeWidth: 5,
        fillColor: Colors.deepPurple.withOpacity(0.1),
        geodesic: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          target: LatLng(13.63961, 100.62485), zoom: 15),
                      markers: Set.from(myMarker),
                      polygons: _polygone,
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
            //get location from marker button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Row(
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Save"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      points.remove(points.last);
                      myMarker.remove(myMarker.last);
                      setState(() {
                        _setPolygon();
                      });
                    },
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.redo,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
