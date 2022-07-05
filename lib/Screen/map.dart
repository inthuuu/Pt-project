import 'dart:developer';
import 'dart:math';
import 'package:drone_for_smart_farming/Screen/adddrone.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:provider/provider.dart';
import '../blocs/application_bloc.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
const kGoogleApiKey = "AIzaSyCUk9-9SOgcWJNMpNV8tGncMsVhnqnhNf8";

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
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18.0));
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<Applicationbloc>(context);
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddDrone()));
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
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                      mapType: MapType.hybrid,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference(0, 18),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              applicationBloc.currentLocation!.latitude,
                              applicationBloc.currentLocation!.longitude),
                          zoom: 15),
                      markers: Set.from(myMarker),
                      onTap: _onAddMarkerButtonPressed),
                  Positioned(
                    top: 20,
                    left: 30,
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
