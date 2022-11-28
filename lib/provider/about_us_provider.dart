import 'package:flutter/material.dart';

class AboutUsProvider with ChangeNotifier{
  bool isLastPage = false;
  getPageData() => this.isLastPage;
  
  setLastPageData(bool isLastPage){
    this.isLastPage = isLastPage;
    notifyListeners();
  }
}