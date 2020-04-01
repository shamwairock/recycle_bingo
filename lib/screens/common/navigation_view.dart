import 'package:flutter/material.dart';
import 'package:recyclebingo/screens/about/about_view.dart';
import 'package:recyclebingo/screens/home/home_view.dart';
import 'package:recyclebingo/screens/map/map_view.dart';
import 'package:recyclebingo/util/trace_logger.dart';

class NavigationView extends StatefulWidget {
  @override
  _NavigationViewState createState() => _NavigationViewState();
}


class _NavigationViewState extends State<NavigationView> {

  int _currentTabIndex = 0;

  final List<Widget> _widgets = [
    HomeView(),
    MapView(),
    AboutView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentTabIndex = index;
      Logger.write('Current Index ' + _currentTabIndex.toString());
    });
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _widgets[_currentTabIndex],
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
            icon: Icon(Icons.info),
            title: Text('About'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTabIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black54,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}