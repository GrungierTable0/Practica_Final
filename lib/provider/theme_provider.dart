import 'package:flutter/material.dart';
import 'package:proyecto_final/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData? _themeData = temaDia();
  getthemeData() => this._themeData;
  
  setthemeData(ThemeData theme){
    this._themeData = theme;
    notifyListeners();
  }

  //double _dimenFont = 1;

  /*getdimenFont() => this._dimenFont;
  setdimenFont(double value){
    this._dimenFont = value;
    notifyListeners();
  }*/
}