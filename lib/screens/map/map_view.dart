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
  StreamSubscription _locationSubscription;
  Marker marker;
  Circle circle;

  void _onMapCreated(GoogleMapController controller) {
    Logger.write('_onMapCreated');
    _controller.complete(controller);
  }

  static final CameraPosition _initialCameraPosition = new CameraPosition(
      target: LatLng(37.4128156834, -122.089978507),
      zoom: 14);

  Future<Uint8List> getMarker() async{
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/garbage-truck.png");
    return byteData.buffer.asUint8List();
  }

  void _getCurrentLocation() async {
    Logger.write('_getCurrentLocation');

    Uint8List imageData = await getMarker();
    var location = await _locationTracker.getLocation();
    updateMarkerAndCircle(location, imageData);

    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }

    _locationSubscription =
        _locationTracker.onLocationChanged.listen((newLocationData) async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(target: LatLng(
                  newLocationData.latitude, newLocationData.longitude),
                  zoom: 18)));
          updateMarkerAndCircle(newLocationData, imageData);
        });
  }

  void updateMarkerAndCircle(LocationData newLocationData, Uint8List imageData){
    LatLng latLng = LatLng(newLocationData.latitude, newLocationData.longitude);
    this.setState((){
      marker = new Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation: newLocationData.heading,
        draggable: false,
        zIndex: 2,
        flat:true,
        anchor:Offset(0.5,0.5),
        icon: BitmapDescriptor.fromBytes(imageData)
      );
      circle = Circle(
        circleId: CircleId('Car'),
        radius: newLocationData.accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70)
      );
    });
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
                markers: Set.of((marker != null) ? [marker] : []),
                circles: Set.of((circle != null) ? [circle] : []),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: Icon(Icons.location_searching),
      ),
    );
  }
}