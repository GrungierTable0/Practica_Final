import 'package:flutter/material.dart';

class NewPublicationProvider with ChangeNotifier{
  String Breed = 'Papillón';
  getBreedData() => this.Breed;
  
  setBreedData(String Breed){
    this.Breed = Breed;
    notifyListeners();
  }
}