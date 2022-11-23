// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, unnecessary_new

import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart'; // For Calendor

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick_shift/constants.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  //TextEditingControllers
  final _searchSourceController = TextEditingController();
  final _searchDestinationController = TextEditingController();
  final _dateController = TextEditingController();

  final Set<Polyline> _polyLine = {};

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingofMap = 0;

  late LatLng destination;
  late LatLng source;

  Set<Marker> markers = {};

  // Veichle Type Field Variables
  final List<String> veichleTypes = [
    'Small',
    'Medium',
    'Large',
  ];
  String? selectedVeichletype;

  // Extra Service Field Variables
  final List<String> extraServiceType = [
    'Yes',
    'No',
  ];
  String? selectedOptionForExtraService;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<String> showGoogleAutoComplete() async {
    const kGoogleApiKey = "AIzaSyCGdkjJ8ZIZzupMHqv-OoeD9n3PY4WQnP4";

    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "in",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      types: ["(cities)"],
      hint: "Search City",
      components: [new Component(Component.country, "in")],
    );
    return p!.description!;
  }

  void drawPolyLine(String placeId) {
    _polyLine.clear();
    _polyLine.add(Polyline(
      polylineId: PolylineId(placeId),
      visible: true,
      points: [source, destination],
      color: Colors.purple,
      width: 5,
    ));
  }

  DateTime _datetime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _datetime = value!;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_datetime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: defaultBackgroundColor,
      drawer: myDrawer,
      body: Stack(
        // Using Stack because the Box is above the Google Map
        children: [
          GoogleMap(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.40),
            markers: markers,
            polylines: _polyLine,
            //padding: EdgeInsets.only(bottom: bottomPaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locatePosition();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 315.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Hi there !",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Where to SHIFT ?",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                        ),
                        SizedBox(height: 15),
                        // Book Schedule from Calendor
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            //key: ,
                            child: TextField(
                              readOnly: true,
                              onTap: _showDatePicker,
                              controller: _dateController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Enter Date of Shifting',
                                prefixIcon: Icon(Icons.calendar_month),
                                contentPadding: EdgeInsets.all(12.0),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Enter Source Location
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            //key: ,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                String selectedPlace =
                                    await showGoogleAutoComplete();
                                _searchSourceController.text = selectedPlace;
                                List<geoCoding.Location> locations =
                                    await geoCoding
                                        .locationFromAddress(selectedPlace);
                                source = LatLng(locations.first.latitude,
                                    locations.first.longitude);
                                setState(() {
                                  markers.add(Marker(
                                      markerId: MarkerId(selectedPlace),
                                      infoWindow: InfoWindow(
                                        title: 'Source: $selectedPlace',
                                      ),
                                      position: source));
                                });
                                newGoogleMapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: source, zoom: 14)));
                              },
                              controller: _searchSourceController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Search source location',
                                prefixIcon:
                                    Icon(Icons.search), // Adds Email Icon
                                contentPadding: EdgeInsets.all(12.0),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Destination Field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            //key: ,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                String selectedPlace =
                                    await showGoogleAutoComplete();
                                _searchDestinationController.text =
                                    selectedPlace;
                                List<geoCoding.Location> locations =
                                    await geoCoding
                                        .locationFromAddress(selectedPlace);
                                destination = LatLng(locations.first.latitude,
                                    locations.first.longitude);
                                setState(() {
                                  markers.add(Marker(
                                      markerId: MarkerId(selectedPlace),
                                      infoWindow: InfoWindow(
                                        title: 'Destination: $selectedPlace',
                                      ),
                                      position: destination));
                                  drawPolyLine(selectedPlace);
                                });
                                drawPolyLine(selectedPlace);
                                newGoogleMapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: destination, zoom: 14)));
                              },
                              controller: _searchDestinationController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Enter Destination',
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.all(12.0),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Enter Vehicle Type Dropdown Field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.all(12.0),
                                hintText: 'Enter Veichle Type',
                                prefixIcon: Icon(Icons.fire_truck_sharp),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: veichleTypes
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                // Do Smoething here
                                setState(() {
                                  selectedVeichletype = value.toString();
                                });
                              },
                              onSaved: (value) {
                                selectedVeichletype = value.toString();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Enter No. of Vehicle Required (Not Dropdown Keyboard Type Number only)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            //key: ,
                            child: TextFormField(
                              //controller: ,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Enter No. of Veichles Required',
                                prefixIcon:
                                    Icon(Icons.numbers), // Adds Email Icon
                                contentPadding: EdgeInsets.all(12.0),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),

                        // Extra Services Field (Yes or No) Dropdown Field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Form(
                            child: DropdownButtonFormField2(
                              //alignment: Alignment.centerLeft,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.all(12.0),
                                hintText: 'Do you want extra Services?',
                                prefixIcon: Icon(Icons.price_check),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: extraServiceType
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                // Do Smoething here
                                setState(() {
                                  selectedOptionForExtraService =
                                      value.toString();
                                });
                              },
                              onSaved: (value) {
                                selectedOptionForExtraService =
                                    value.toString();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Request SHIFT Submit Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Request SHIFT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
