import 'package:flutter/material.dart';

class FeedProvider with ChangeNotifier{
  int screenIndex = 0;
  getIndexData() => this.screenIndex;
  
  setIndexData(int screenIdex){
    this.screenIndex = screenIdex;
    notifyListeners();
  }
}