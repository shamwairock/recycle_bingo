import 'package:flutter/material.dart';
import 'package:recyclebingo/screens/common/navigation_view.dart';
import 'package:recyclebingo/util/trace_logger.dart';
import 'styles/font_style.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:splashscreen/splashscreen.dart';

void main() =>
    runApp(
        new MaterialApp(
          home: new MyApp(),
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.orange,
            accentColor: Colors.orange,
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title:  AppBarTextStyle
              )
            )
          )
        )
    );

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _requestPermission();
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new NavigationView(),
        title: new Text('Recycle Bingo',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white
            ),
        ),
        image: new Image.asset('assets/images/splash-screen-icon.png', width: 300.0, height: 300.0,),
        backgroundColor: Colors.orange[600],
        styleTextUnderTheLoader: SplashScreenTitleTextStyle,
        loadingText: Text('by 4GM',
          style: SplashScreenLoaderTextStyle
        ),
        //photoSize: 100.0,
        //onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.white,
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


