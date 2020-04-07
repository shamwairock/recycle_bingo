import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 14.0;
const SmallTextSize = 9.0;

const String FontNameDefault = 'Montserrat';

const ItalicTextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w300,
    fontSize: MediumTextSize,
    fontStyle: FontStyle.italic,
    color: Colors.black
);

const AppBarTextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w300,
    fontSize: MediumTextSize,
    color: Colors.white
);

const SplashScreenTitleTextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w300,
    fontSize: MediumTextSize,
    color: Colors.white
);

const SplashScreenLoaderTextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w300,
    fontSize: SmallTextSize,
    color: Colors.white
);


const TitleTextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w600,
    fontSize: MediumTextSize,
    color: Colors.black54
);

const Body1TextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w300,
    fontSize: BodyTextSize,
    color: Colors.black45
);