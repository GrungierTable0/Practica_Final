import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserModel{
  String? idUser;
  String? imageUser;
  String? nameUser;
  String? emailUser;
  String? proveedorUser;

  UserModel({this.idUser,this.imageUser,this.nameUser,this.emailUser,this.proveedorUser});
  

  factory UserModel.fromJSON(Map<String, dynamic> mapUser) {
    return UserModel(
      idUser: mapUser['idUser'],
      imageUser: mapUser['imageUser']??"https://support.pega.com/sites/default/files/pega-user-image/460/REG-459913.png",
      nameUser: mapUser['nameUser']??"",
      emailUser: mapUser['emailUser']??"",
      proveedorUser: mapUser['prooveedorUser']??""
    );
  }
  

}