import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/firebase/breeds_firebase.dart';
import 'package:proyecto_final/models/breed_model.dart';
import 'package:proyecto_final/models/user_model.dart';

class BreedsScreen extends StatelessWidget {
  const BreedsScreen({super.key, required this.userModel});
  final UserModel userModel;
  
  @override
  Widget build(BuildContext context) {
    return BreedsScreenWidget(userModel: userModel,);
  }
}

class BreedsScreenWidget extends StatefulWidget {
  const BreedsScreenWidget({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<BreedsScreenWidget> createState() => _BreedsScreenWidgetState();
}

class _BreedsScreenWidgetState extends State<BreedsScreenWidget> {
  BreedFirebase _breedFirebase = BreedFirebase();
  
  var resBreeds;
  var resMyBreeds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _breedFirebase.userID=widget.userModel.idUser;
    resBreeds=_breedFirebase.readBreeds();
    resMyBreeds=_breedFirebase.readBreedsFromUser();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Razas',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          children: [
            Text(
              'Las razas a las que estas suscrito',
              textAlign: TextAlign.center,
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
                    children: breeds.map((breeModel)=>buildBreed(breeModel,true)).toList(),
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
            
            Text(
              'Razas que Tenemos',
              textAlign: TextAlign.center,
              style: GoogleFonts.courgette(
                fontSize: 30,
              ),  
            ),
            StreamBuilder<List<BreedModel>>(
              stream: resBreeds,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final breeds = snapshot.data!;
                  return ListView(
                    shrinkWrap: true,
                    children: breeds.map((breeModel)=>buildBreed(breeModel,false)).toList(),
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text('Error al obtener los datos'),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
                       
          ],
        ),
      ),
    );
  }
  Widget buildBreed(BreedModel breedModel, bool sus){
    if(breedModel.raza!.compareTo("Otra Raza")!=0){
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Text(breedModel.raza!,style: TextStyle(fontSize: 20),),
              sus?Icon(Icons.remove):Icon(Icons.add),
            ],
          ),
        ),
        onTap: () async{
          if(sus){
            _breedFirebase.deleteBreedForUser(breedModel);
          }else{
            try{
              _breedFirebase.createBreedForUser(breedModel);

            }catch(e){
              print(e);
              FirebaseFirestore.instance.collection("razas${widget.userModel.idUser}").add({
              }).then((_){
                print("collection created");
              }).catchError((_){
                print("an error occured");
              });

            }
          }
          print(breedModel.raza);
        },
        
      );
    }else{
      return SizedBox.shrink();
    }
  }
}