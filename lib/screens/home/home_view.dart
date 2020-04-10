import 'package:flutter/material.dart';
import 'package:recyclebingo/util/trace_logger.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeView extends StatelessWidget{

  static const double _hPadding = 16.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('recycle bingo'),
        ),
        backgroundColor: const Color(0xffded3ad),
        body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//              Container(
//                  padding: const EdgeInsets.fromLTRB(_hPadding, 32.0, _hPadding, 0),
//                  child:Text('Hello recycle rangers', style: Theme.of(context).textTheme.title)
//              ),
//              Container(
//                  padding: const EdgeInsets.fromLTRB(_hPadding, 0, _hPadding, 0),
//                  child:Text('One man\'s Trash is another man\'s Treasure', style: Theme.of(context).textTheme.body1)
//              ),
            ],
          ),

        ),
    );
  }


}