// ignore_for_file: prefer_const_constructors, prefer_final_fields, file_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:drone_for_smart_farming/Screen/selectService.dart';
import 'package:drone_for_smart_farming/blocs/application_bloc.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

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
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 20),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          height: 60,
                          width: 280,
                          child: TextFormField(
                            initialValue: 'ค้นหา',
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          )),
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
