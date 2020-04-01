import 'package:flutter/material.dart';
import 'package:recyclebingo/screens/home/home_view.dart';
import 'styles/font_style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        accentColor: Colors.orange,
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(title:  AppBarTextStyle)
        ),
      ),
      home: HomeView(title: 'recycle bingo'),
      //home: AboutView(),
    );
  }
}
