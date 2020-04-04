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
  Set<Marker> _markers;
  Set<Circle> _circles;

  static final CameraPosition _initialCameraPosition = new CameraPosition(
      target: LatLng(1.290270, 103.851959), zoom:10);

  void _onMapCreated(GoogleMapController controller) {
    Logger.write('_onMapCreated');
    _controller.complete(controller);
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
  }

  Future<void> _zoomToCurrentLocation() async{
    _zoomLocation(currentLocationLatLng);
  }

  Future<void> onInit() async{
    currentLocationLatLng = await _getCurrentLocation();
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/garbage-truck.png');

    Marker marker = new Marker(markerId: MarkerId('Marker1'),
        position: currentLocationLatLng,
        icon: pinLocationIcon);

    ArgumentError.checkNotNull(pinLocationIcon);
    _markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {


    onInit();

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