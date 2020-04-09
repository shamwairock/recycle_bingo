import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclebingo/util/GoogleMapsServices.dart';
import 'package:recyclebingo/util/number_util.dart';
import 'package:recyclebingo/util/trace_logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapView extends StatefulWidget {

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  Location _locationTracker = Location();
  LatLng _currentLocationLatLng;
  BitmapDescriptor _pinLocationIcon;
  Set<Marker> _markers = new Set<Marker>();
  Set<Circle> _circles = new Set<Circle>();
  Set<Polyline> _polylines = new Set<Polyline>();
  Marker _selectedMarker;

  static final CameraPosition _initialCameraPosition = new CameraPosition(
      target: LatLng(1.290270, 103.851959), zoom:10);

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/styles/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    Logger.write('_onMapCreated');
    controller.setMapStyle(_mapStyle);
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
        new CameraPosition(
            target: LatLng(latLng.latitude, latLng.longitude),
            zoom: 16,
        ))
    );

    Logger.write('_zoomLocation done');
  }

  Future<void> _zoomToCurrentLocation() async{
    Logger.write('_zoomToCurrentLocation');

    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        'assets/images/current-orange.png');
    _currentLocationLatLng = await _getCurrentLocation();

    var marker = new Marker(markerId: MarkerId('MyLocation'),
        position: _currentLocationLatLng,
        icon: _pinLocationIcon);

    final Circle circle = new Circle(
        circleId: CircleId('MyCircle'),
        center: LatLng(_currentLocationLatLng.latitude, _currentLocationLatLng.longitude),
        radius: 100,
        fillColor: Colors.orange.withOpacity(0.2),
        strokeColor: Colors.transparent,
        zIndex: 2);

    setState(() {
      _markers.add(marker);
      _circles.add(circle);
    });
    await _zoomLocation(_currentLocationLatLng);
    await _drawRecycleBin();
    Logger.write('_zoomToCurrentLocation done');
  }

  Future<void> _drawRecycleBin() async{
    Logger.write('_drawRecycleBin');

    var recycleBinLocations = await _getNearestRecycleBinLocation();

    recycleBinLocations.forEach((LatLng recycleBinLocation) async {

        var icon = await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(),
            'assets/images/current-purple.png');

        var markerId = MarkerId(NumberUtil.createCryptoRandomString().toString());
        var marker = new Marker(markerId: markerId,
            position: recycleBinLocation,
            icon: icon,
            onTap: (){_onMarkerTapped(markerId);},
            infoWindow: InfoWindow(
              title: 'MarkerId: "${markerId.value}"',
            )
        );


        var circle = new Circle(
            circleId: CircleId(NumberUtil.createCryptoRandomString().toString()),
            center: recycleBinLocation,
            radius: 80,
            fillColor: Colors.purple.withOpacity(0.1),
            strokeColor: Colors.transparent,
            zIndex: 2);

        setState(() {
          _markers.add(marker);
          _circles.add(circle);
        });
    });
  }

  Future<void> _onMarkerTapped(MarkerId markerId) async {
    Logger.write('_onMarkerTapped markerId: "${markerId.value}"');

    final GoogleMapController controller = await _controller.future;

    if (_selectedMarker != null) {
      if (_selectedMarker.markerId == markerId) {
        controller.hideMarkerInfoWindow(markerId);
        return;
      }
    }

    if (_selectedMarker != null) {
      controller.hideMarkerInfoWindow(_selectedMarker.markerId);
    }

    _selectedMarker =
        _markers.firstWhere((marker) => marker.markerId == markerId);
    controller.showMarkerInfoWindow(markerId);

    var polyline = await _getRoute();

    //try add line here
    setState(() {
      _polylines = new Set();
      _polylines.add(polyline);
    });

  }

  Future<Polyline> _getRoute() async{
    var pointSource = _currentLocationLatLng;
    var pointDestination = _selectedMarker.position;

    var points = await GoogleMapsServices().getRouteCoordinates(pointSource, pointDestination);

    var polyline = new Polyline(
        polylineId: PolylineId(NumberUtil.createCryptoRandomString().toString()),
        consumeTapEvents: true,
        color: Colors.orange,
        width: 5,
        geodesic: true,
        points: points,
        visible: true,
        jointType: JointType.round
    );

    return polyline;
  }

  void _onMapLongPressed(LatLng argument) {
    // add marker
  }

  Future<void> _onMapTapped(LatLng argument) async {
    // maybe clear some state
    final GoogleMapController controller = await _controller.future;

    _markers.forEach((marker){
      controller.hideMarkerInfoWindow(marker.markerId);
    });

    _selectedMarker = null;
  }

  Future<Set<LatLng>> _getNearestRecycleBinLocation() async{
    LatLng recycleBinPosition1 = LatLng(1.3639,103.8960);
    LatLng recycleBinPosition2 = LatLng(1.3640,103.8945);
    LatLng recycleBinPosition3 = LatLng(1.3633,103.8942);
    LatLng recycleBinPosition4 = LatLng(1.3628,103.8948);
    LatLng recycleBinPosition5 = LatLng(1.3646,103.8947);
    LatLng recycleBinPosition6 = LatLng(1.3648,103.8958);
    LatLng recycleBinPosition7 = LatLng(1.3696,103.8871);

    var locations = new Set<LatLng>();
    locations.add(recycleBinPosition1);
    locations.add(recycleBinPosition2);
    locations.add(recycleBinPosition3);
    locations.add(recycleBinPosition4);
    locations.add(recycleBinPosition5);
    locations.add(recycleBinPosition6);
    locations.add(recycleBinPosition7);

    // simulate slow down
    await Future.delayed(const Duration(milliseconds: 3000), () {

    });

    return locations;
  }

  void _onCameraMoveStarted() {
    Logger.write('_onCameraMoveStarted');
  }

  void _onCameraIdle() {
    Logger.write('_onCameraIdle');
  }

  Future<void> _onCameraMove(CameraPosition cameraPosition) async {
    //Logger.write('_onCameraMove');
    //Logger.write('Latitude: "${cameraPosition.target.latitude}"');
    //Logger.write('Longitude: "${cameraPosition.target.latitude}"');
    //Logger.write('Zoom: "${cameraPosition.zoom}"');
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
                onTap: _onMapTapped,
                onLongPress: _onMapLongPressed,
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                markers: _markers,
                circles: _circles,
                polylines: _polylines,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                scrollGesturesEnabled: true,
                compassEnabled: true,
                onCameraMove: _onCameraMove,
                onCameraIdle: _onCameraIdle,
                onCameraMoveStarted: _onCameraMoveStarted,
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