import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final/firebase/breeds_firebase.dart';
import 'package:proyecto_final/models/breed_model.dart';
import 'package:proyecto_final/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ProfileScreenWidget(userModel: userModel,);
  }
}
class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget({super.key,required this.userModel});
  final UserModel userModel;
  
  @override
  State<ProfileScreenWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  BreedFirebase _breedFirebase = BreedFirebase();
  var resMyBreeds;

  @override
  void initState() {
    super.initState();
    _breedFirebase.userID=widget.userModel.idUser;
    resMyBreeds = _breedFirebase.readBreedsFromUser();
  }
  
  List<String> images = <String>[
    'https://www.hogarmania.com/archivos/201705/mascotas-perros-razas-caniche-668x400x80xX.jpg',
    'https://www.zooplus.es/magazine/wp-content/uploads/2021/06/Caniche-enano.jpeg',
    'https://photo.tuchong.com/3541468/f/256561232.jpg',
    'https://photo.tuchong.com/16709139/f/278778447.jpg',
    'https://photo.tuchong.com/15195571/f/233361383.jpg',
    'https://photo.tuchong.com/5040418/f/43305517.jpg',
    'https://photo.tuchong.com/3019649/f/302699092.jpg'
  ];
  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.platform.pickImage (source: ImageSource.gallery);
    if(picture!=null){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: GoogleFonts.acme(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions:[
          Image.asset('assets/logo.png',width: 50,)
        ],
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width-180),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(widget.userModel.imageUser!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Column(
                      children: [
                        Text(
                          'Te damos la bienvenida\n${widget.userModel.nameUser}',
                          style: GoogleFonts.indieFlower(
                            fontSize: 25
                          ),
                        ),
                        Text(
                          '${widget.userModel.emailUser}',
                          style: GoogleFonts.indieFlower(
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                  ),
                    
                ],
              ),

              Divider(
                color: Theme.of(context).backgroundColor,
                height: 50,             
              ),
              Text(
                'Razas a las que estas suscrito!!',
                textAlign: TextAlign.left,
                style: GoogleFonts.courgette(
                  fontSize: 30,
                ),  
              ),
              StreamBuilder<List<BreedModel>>(
                stream: resMyBreeds,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final breeds = snapshot.data!;
                    return ListView(
                      shrinkWrap: true,
                      children: breeds.map((breeModel)=>buildBreed(breeModel)).toList(),
                    );
                  }else if(snapshot.hasError){
                    return Center(
                      child: Text('Error al obtener los datos'),
                    );
                  }else{
                    return Text(
                      'No te has suscrito a ninguna Raza',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),  
                    );
                  }
                },
              ),
              Divider(
                color: Theme.of(context).backgroundColor,
                height: 50,             
              ),
              Row(
                children: [
                  Text(
                    'Tus Perritos!!',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.courgette(
                      fontSize: 30,
                    ),  
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    color: Theme.of(context).cardColor,
                    child: GestureDetector(
                      onTap: (){
                        _openGallery(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text('Subir Foto')
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              true?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Container(
                    width: MediaQuery.of(context).size.width/2-15,
                    height: MediaQuery.of(context).size.width/2-15,
                    child: Image.network(images[0],fit: BoxFit.cover,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2-15,
                    height: MediaQuery.of(context).size.width/2-15,
                    child: Image.network(images[1],fit: BoxFit.cover,),
                  ),
                ],
              )
              :
              Container(
                child: Center(
                  child: Image.network('https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png'),
                ),
              )
              ,
              
            ],
            
          )
        ),
      ),

    );
  }
  Widget buildBreed(BreedModel breedModel){
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Text(breedModel.raza!,style: TextStyle(fontSize: 20),),
              Icon(Icons.remove),
            ],
          ),
        ),
        onTap: () async{
          
          _breedFirebase.deleteBreedForUser(breedModel);
          
        },
        
      );
    
  }
}