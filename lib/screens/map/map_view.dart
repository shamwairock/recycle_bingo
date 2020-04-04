import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclebingo/util/trace_logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  Completer<GoogleMapController> _controller = Completer();
  Location _locationTracker = Location();
  LatLng currentLocationLatLng;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = new Set<Marker>();
  Set<Circle> _circles =new Set<Circle>();

  static final CameraPosition _initialCameraPosition = new CameraPosition(
      target: LatLng(1.290270, 103.851959), zoom:10);

  void _onMapCreated(GoogleMapController controller) {
    Logger.write('_onMapCreated');
    _controller.complete(controller);
    onInit();
  }

  Future<LatLng> _getCurrentLocation() async{
    Logger.write('_getCurrentLocation');

    var location = await _locationTracker.getLocation();
    return LatLng(location.latitude, location.longitude);
  }

  Future<void> _zoomLocation(LatLng latLng) async {
    Logger.write('_zoomLocation');

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        new CameraPosition(target: LatLng(
            latLng.latitude, latLng.longitude),
            zoom: 18)));

    Logger.write('_zoomLocation done');
  }

  Future<void> _zoomToCurrentLocation() async{
    Logger.write('_zoomToCurrentLocation');

    _zoomLocation(currentLocationLatLng);

    Logger.write('_zoomToCurrentLocation done');
  }

  Future<void> onInit() async{
    Logger.write('onInit');

    currentLocationLatLng = await _getCurrentLocation();
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/garbage-truck-small.png');

    Logger.write('onInit 1');
    final Marker marker = new Marker(markerId: MarkerId('Marker1'),
        position: currentLocationLatLng,
        icon: pinLocationIcon);
    Logger.write('onInit 2');

    final Circle circle = new Circle(
        circleId: CircleId('Cirle1'),
        center: LatLng(currentLocationLatLng.latitude,currentLocationLatLng.longitude),
        radius: 20,
        fillColor: Colors.lightGreenAccent.withOpacity(0.5),
        strokeColor: Colors.transparent,
        zIndex: 2

    );
    setState(() {
      _markers.add(marker);
      _circles.add(circle);
    });
    Logger.write('onInit 3');
    Logger.write('onInit done');
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Map'),
      ),
      body: Stack(
          children: <Widget>[
            GoogleMap(
                onMapCreated: _onMapCreated,
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                markers: _markers,
                circles: _circles,
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _zoomToCurrentLocation,
        child: Icon(Icons.location_searching),
      ),
    );
  }
}