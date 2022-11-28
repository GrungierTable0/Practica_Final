import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:github/github.dart';
import 'package:proyecto_final/models/breed_model.dart';

class BreedFirebase{
  String? userID;
  
  BreedFirebase({this.userID});


  Stream<List<BreedModel>> readBreeds() => FirebaseFirestore.instance.collection('razas').snapshots().map(((snapshot) {
    return snapshot.docs.map((doc) => BreedModel.fromJSON(doc.data())).toList();
  }));

  Stream<List<BreedModel>> readBreedsFromUser() => FirebaseFirestore.instance.collection('razas${userID}').snapshots().map(((snapshot) 
    => snapshot.docs.map((doc) => BreedModel.fromJSON(doc.data())).toList()
  ));
  
  Future createBreedForUser(BreedModel breedModel) async{
    final docUser = FirebaseFirestore.instance.collection('razas${userID}').doc('${breedModel.id}');
    final json = breedModel.toJSON();
    await docUser.set(json);
  }

  Future deleteBreedForUser(BreedModel breedModel) async{
    final docUser = FirebaseFirestore.instance.collection('razas${userID}').doc('${breedModel.id}');
    await docUser.delete();
  }

}