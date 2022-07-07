// ignore_for_file: prefer_const_constructors, prefer_final_fields
import 'dart:collection';
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
const kGoogleApiKey = "AIzaSyCUk9-9SOgcWJNMpNV8tGncMsVhnqnhNf8";

class _PolygonScreenState extends State<PolygonScreen> {
  late GoogleMapController mapController;
  late CameraPosition kGooglePlex;

  List<Marker> myMarker = [];
  late LatLng point;

  Set<Polygon> _polygone = HashSet<Polygon>();
  List<LatLng> points = [];
  List<LatLng> pointsSort = [];
  List<LatLng> newPoint = [];

  List<LatLng> upperLng = [];
  List<LatLng> lowerLng = [];

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
    setState(() {
      points.add(point);
      _setPolygon();
    });
  }

  //draw polygon on google map
  void _setPolygon() {
    //sort lat, long
    pointsSort = [...points];
    _boundaryArea(pointsSort);

    //draw polygon
    _polygone.clear();
    _polygone.add(Polygon(
        polygonId: PolygonId('1'),
        points: newPoint,
        strokeColor: Colors.deepPurple,
        strokeWidth: 5,
        fillColor: Colors.deepPurple.withOpacity(0.1),
        geodesic: true));
  }

  void _boundaryArea(List<LatLng> pointsSort) {
    //sort latitude
    quickSort(pointsSort, 0, pointsSort.length - 1);
    upperLng = [];
    lowerLng = [];
    
    var sum = 0.0;
    for (var i = 0; i < pointsSort.length; i++) {
      sum += (pointsSort[i].longitude);
    }
    var avg = sum / points.length;
    //sort l
    for (int i = 0; i < pointsSort.length; i++) {
      if (pointsSort[i].longitude > avg) {
        upperLng.add(pointsSort[i]);
      } else {
        lowerLng.add(pointsSort[i]);
      }
      newPoint = [];
      newPoint = [...lowerLng, ...upperLng.reversed];
    }
  }

  void swap(List<LatLng> pointsSort, int i, int j) {
    var temp = pointsSort[i];
    pointsSort[i] = pointsSort[j];
    pointsSort[j] = temp;
  }

  partition(List<LatLng> pointsSort, var low, var high) {
    //pivot
    var pivot = pointsSort[high].latitude;

    int i = (low - 1);
    for (int j = low; j <= high - 1; j++) {
      if (pointsSort[j].latitude < pivot) {
        i++;
        swap(pointsSort, i, j);
      }
    }
    swap(pointsSort, i + 1, high);
    return (i + 1);
  }

  void quickSort(List<LatLng> pointsSort, int low, int high) {
    if (low < high) {
      int pi = partition(pointsSort, low, high);

      quickSort(pointsSort, low, pi - 1);
      quickSort(pointsSort, pi + 1, high);
    }
  }

  //search location
  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      strictbounds: false,
      mode: Mode.overlay,
      language: "th",
      types: [""],
      decoration: InputDecoration(
        hintText: 'ค้นหา',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "th")],
    );
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!
        .showBottomSheet((context) => Text(response.errorMessage!));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? scaffold) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15.0));
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
                        onPressed: () {
                          _handlePressButton();
                        },
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
                        myMarker.remove(myMarker.last);
                        points.remove(points.last);
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
