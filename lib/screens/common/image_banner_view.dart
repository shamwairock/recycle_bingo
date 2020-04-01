import 'dart:ui';
import 'package:flutter/material.dart';

class ImageBannerView extends StatelessWidget{
  final String _assetPath;

  ImageBannerView(this._assetPath);

  @override
  Widget build(BuildContext context){
    return Container(
      constraints: BoxConstraints.expand(
        height: 300.0,
      ),
      decoration: BoxDecoration(
          color: Colors.grey
      ),
      child: Image.asset(
          this._assetPath,
          fit: BoxFit.cover
      ),
    );
  }
}