import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/firebase/breeds_firebase.dart';
import 'package:proyecto_final/models/breed_model.dart';
import 'package:proyecto_final/models/user_model.dart';
import 'package:proyecto_final/provider/new_publicacion_privider.dart';

class NewPublicationScreen extends StatelessWidget {
  const NewPublicationScreen({super.key, required this.userModel, required this.imageNewPublication});
  final UserModel userModel;
  final PickedFile imageNewPublication;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewPublicationProvider(),
      child: NewPublicationScreenWidget(userModel: userModel,imageNewPublication: imageNewPublication,),
    );
    
  }
}

class NewPublicationScreenWidget extends StatefulWidget {
  const NewPublicationScreenWidget({super.key, required this.userModel, required this.imageNewPublication});
  final UserModel userModel;
  final PickedFile imageNewPublication;

  @override
  State<NewPublicationScreenWidget> createState() => _NewPublicationScreenWidgetState();
}

class _NewPublicationScreenWidgetState extends State<NewPublicationScreenWidget> {
  TextEditingController txtConDesc = TextEditingController();
  BreedFirebase _breedFirebase = BreedFirebase();
  
  var resBreeds;
  @override
  void initState() {
    super.initState();
    resBreeds=_breedFirebase.readBreeds();
  }
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  
  @override
  Widget build(BuildContext context) {
    NewPublicationProvider _breed = Provider.of<NewPublicationProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => NewPublicationProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Nueva Publicacion',
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
    
        body: ListView(
          shrinkWrap: true,
    
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(
                        widget.imageNewPublication.path,
                        
                      ))
                    )
                    
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: TextField(
                controller: txtConDesc,
                decoration: InputDecoration(
                  labelText: 'Descripcion',
                  hintText: 'Escribe aqui...',
                  
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: StreamBuilder<List<BreedModel>>(
                stream: resBreeds,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final breeds = snapshot.data!;
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: _breed.getBreedData(),
                      iconDisabledColor: Colors.blue,
                      iconEnabledColor: Colors.blue,
                      focusColor: Colors.blue,
                      items: breeds.map((data) =>DropdownMenuItem<String>(
                          child: Text(data.raza!),
                          value: data.raza,
                      )).toList(),
                      onChanged: (value) {
                        _breed.setBreedData(value!);
                      }
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text('${snapshot.error}'),);
                  }else{
                    return CircularProgressIndicator();
                  }
                            
                          
                }
              ),
            ),
    
            
            Container(
              margin: const EdgeInsets.only(top: 150.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  
                  TextButton( 
                      
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      
                      padding: const EdgeInsets.all(16.0),
                      textStyle: GoogleFonts.indieFlower(fontSize: 20),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Descartar'), 
                  ),
            
                  TextButton(
                    
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: GoogleFonts.indieFlower(fontSize: 20),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    ),
                    onPressed: () async {
                      if("".compareTo(txtConDesc.text)!=0){
                          
                            /*
                            Position position = await _getGeoLocationPosition();
                            double lat = position.latitude;
                            double long = position.longitude;
    
                            List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
                            Placemark place = placemarks[0];
                            String Address = '${place.street}, ${place.subLocality}, ${place.locality}';
    
                            var now = new DateTime.now();
                            var formatter = new DateFormat('yyyy-MM-dd');
                            String formattedDate = formatter.format(now);
    
                            final File image = File(arguments!.path);
                            Directory carpeta = await getApplicationDocumentsDirectory();
                            final String path = carpeta.path;
                            final String finalpath = '$path/image'+Random().nextInt(1000).toString()+'.jpg'; 
    
                            final nombreBD = 'MyBFBD';
                            String rutaBD = join(carpeta.path, nombreBD);
    
                            String nameUser = 'Jaramillo';
                            String userImage = 'assets/User-Default.jpg';
    
                            _database?.insertar({
                              'imageUser':userImage,
                              'nameUser':nameUser,
                              'message': txtConDesc.text,
                              'date': formattedDate,
                              'image': finalpath,
                              'location': Address,
                              'lat': lat,
                              'long':long
                            }, 'tblPublicaciones').then((value) async{
                              final File localImage = await image.copy(finalpath);  
                              Navigator.popAndPushNamed(context,'/feed');
                              final snackBar =
                                  SnackBar(content: Text('Publicacion realizada Correctamente!'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            });
                            
                           */
                            
                      }else{
                        DialogBackground(
                          dialog:  AlertDialog(
                            title: Text("ERROR!!",style: TextStyle(color: Colors.red,fontSize: 30),),
                            content: Text(
                              "¡Llenar el Campo de descripción!",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20  
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Okay",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16
                                  ),
                                ),        
                                onPressed: () => Navigator.pop(context)
                              ),
                            ],
                          ),
                        ).show(context);
                      }
                    },
                    child: const Text('Publicar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}