// ignore_for_file: prefer_const_constructors, prefer_final_fields, file_names

import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:drone_for_smart_farming/Screen/selectService.dart';
import 'package:drone_for_smart_farming/blocs/application_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
const kGoogleApiKey = "AIzaSyCUk9-9SOgcWJNMpNV8tGncMsVhnqnhNf8";

class _PolygonScreenState extends State<PolygonScreen> {
  late GoogleMapController mapController;
  late CameraPosition kGooglePlex;

  List<Marker> myMarker = [];
  late LatLng point;

  Set<Polygon> _polygone = HashSet<Polygon>();
  List<LatLng> points = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //add marker on google map
  void _onAddMarkerButtonPressed(LatLng tappedPoint) {
    setState(() {
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

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      //onError: onError,
      strictbounds: false,
      mode: Mode.overlay,
      language: "th",
      types: ["(cities)"],
      hint: "Search City",
      //startText: city == null || city == "" ? "" : city,
      decoration: InputDecoration(
        hintText: 'ค้นหา',
        fillColor: Color(0xff2f574b),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "th")],
    );

    displayPrediction(p!, homeScaffoldKey.currentState!);
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<Applicationbloc>(context);
    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                      mapType: MapType.hybrid,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference(0, 16),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              applicationBloc.currentLocation!.latitude,
                              applicationBloc.currentLocation!.longitude),
                          zoom: 15),
                      markers: Set.from(myMarker),
                      polygons: _polygone,
                      onTap: _onAddMarkerButtonPressed),
                  //app bar
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      children: [
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
                                      builder: (context) => SelectService()));
                            },
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'ระบุขอบเขต',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 50,
                    right: 60,
                    child: SizedBox(
                      height: 60,
                      width: 280,
                      child: ElevatedButton(
                        onPressed: _handlePressButton,
                        child: Text(
                          "ค้นหา",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  //undo marker
                  Align(
                    alignment: Alignment(0.95, 0.2),
                    child: FloatingActionButton(
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
                    ),
                  ),
                  //next button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        alignment: FractionalOffset.bottomCenter,
                        child: SizedBox(
                          height: 60,
                          width: 280,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'ถัดไป',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff2f574b),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
