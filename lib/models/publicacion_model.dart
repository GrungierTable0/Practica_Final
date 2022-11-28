class publicacionDAO{
  int? id;
  String? imageUser;
  String? nameUser;
  String? message;
  String? date;
  String? image;
  String? location;
  String? lat;
  String? long;
  String? raza;

  publicacionDAO({
    this.id,
    this.imageUser,
    this.nameUser,
    this.message,
    this.date,
    this.image,
    this.location,
    this.lat,
    this.long,
    this.raza
  });

  factory publicacionDAO.fromJSON(Map<String,dynamic> map){
    return publicacionDAO(
      id: map['id'],
      imageUser: map['imageUser'],
      nameUser: map['nameUser'],
      message: map['message'],
      date: map['date'],
      image: map['image'],
      location: map['location'],
      lat: map['lat'],
      long: map['long'],
      raza: map['raza']
    );
  }
  

}