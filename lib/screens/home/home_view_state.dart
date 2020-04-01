import 'package:flutter/material.dart';
import 'package:recyclebingo/screens/common/image_banner_view.dart';
import 'home_view.dart';
import 'dart:developer' as developer;

class HomeViewState extends State<HomeView> {

  int currentTabIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentTabIndex = index;
      developer.log('log me', name: 'my.app.category');
    });
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ImageBannerView("assets/images/boss.jpg"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: Text('Contact'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTabIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}