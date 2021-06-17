
import 'package:flutter/material.dart';

import '../constants.dart';

class MyTheme {
  //Define the dark theme which we will customize..
  final _baseTheme = ThemeData.dark();

  ThemeData getMyTheme() {
    ThemeData result = _baseTheme.copyWith(
      canvasColor: kColorOfCanvas,
      backgroundColor: Colors.white, //kOrangeColor
      accentColor: kOrangeColor,
      scaffoldBackgroundColor: Colors.white,


      primaryColor: kColorOfCanvas,
    );
    return result;
  }
}
