import 'package:flutter/material.dart';
import 'package:recyclebingo/screens/common/navigation_view.dart';
import 'package:recyclebingo/util/trace_logger.dart';
import 'styles/font_style.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    _requestPermission();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        accentColor: Colors.orange,
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(title:  AppBarTextStyle)
        ),
      ),
      home: NavigationView(),
    );
  }

  Future<void> _requestPermission() async {

    var locationStatus = await Permission.location.status;
    Logger.write("locationStatus " + locationStatus.toString());

    if (locationStatus != PermissionStatus.granted) {
      Logger.write("requesting location");
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      Logger.write("requesting location completed");
    }
  }
}
