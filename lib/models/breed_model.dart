class BreedModel{
  String? id;
  String? raza;

  BreedModel({this.id,this.raza});

  Map<String,dynamic> toJSON()=>{
    'id':id,
    'raza':raza
  };

  factory BreedModel.fromJSON(Map<String, dynamic> mapRaza){
    return BreedModel(
      id: mapRaza['id'],
      raza: mapRaza['raza']
    );
  }
}