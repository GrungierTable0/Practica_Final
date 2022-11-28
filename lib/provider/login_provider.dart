import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{
  bool _obscureText = true;
  getOscureData() => this._obscureText;
  
  setOscureData(bool _obscureText){
    this._obscureText = _obscureText;
    notifyListeners();
  }
}