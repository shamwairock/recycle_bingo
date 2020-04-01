import 'package:flutter/material.dart';
import 'package:recyclebingo/screens/common/image_banner_view.dart';

class AboutView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('about'),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ImageBannerView("assets/images/boss.jpg"),
          ],
        )
    );
  }
}