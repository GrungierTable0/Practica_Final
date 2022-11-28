import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_final/models/user_model.dart';
import 'package:proyecto_final/screens/feed_screen.dart';
import 'package:proyecto_final/screens/new_publication_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return HomeScreenWidget(userModel: userModel,);
    
  }
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<HomeScreenWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenWidget> {
  @override
  void initState() {
    super.initState();
    
  }
  
  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.platform.pickImage (source: ImageSource.camera);
    if(picture!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewPublicationScreen(userModel: widget.userModel, imageNewPublication: picture),));
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Best Friend',
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
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.userModel.imageUser!),
              ),
              accountName: Text(widget.userModel.nameUser!),
              accountEmail: Text(widget.userModel.emailUser!),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg'),
                  fit: BoxFit.cover
                ),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/logo.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Sobre Nosotros!!'),
              onTap: (){
                Navigator.popAndPushNamed(context,'/aboutus');
              },
            ),
            ListTile(
              leading: Image.asset('assets/logo.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesion'),
              onTap: (){
                FacebookAuth.instance.logOut();
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.popAndPushNamed(context,'/login');
              },
            ),

          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            UI('assets/creator.jpg', 'Juan Pablo Jaramillo Nieto', 'Encontre este perrito abandonado','Otra raza', '28-11-2022', 'assets/Ejemplo1.jpg', 'Hacienda de Guanave ll 104A, Villas de la Arbolada, Celaya', "20.5576241", "-100.8517272",context),
            UI('assets/creator.jpg', 'Juan Pablo Jaramillo Nieto', 'Encontre este perrito abandonado','Otra raza', '28-11-2022', 'assets/Ejemplo2.jpg', 'Hacienda de Guanave ll 104A, Villas de la Arbolada, Celaya', "20.5576241", "-100.8517272",context),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCamera(context);
        },
        tooltip: 'Nueva Publicación',
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Colors.black,
      ), 
    );
  }
}
Widget UI(
  String imageUser,
  String name,
  String message,
  String raza,
  String datetime,
  String image,
  String ubicacion,
  String latitud,
  String longitud,
  BuildContext context
  ) {
  return new InkWell(
    child: Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0),
      child: Column(
        children: <Widget>[
          Slidable(
            child: new Card(
              child: new Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: new EdgeInsets.only(
                    top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 10),
                      child: new Text(
                        'Raza: $raza',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.courgette(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 10),
                      child: Container(
                        child: Image.asset(image,height: 200,width: 200,)
                        
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 10),
                      child: new Text(
                        '$message',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () {
                              },
                              child: new Icon(
                                LineIcons.heart,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                            new Text(
                              '0',
                            )
                          ],
                        ),
                        new GestureDetector(
                          child: Row(
                            children: <Widget>[
                              new Icon(
                                Icons.chat_bubble_outline,
                                size: 20,
                              ), 
                              Text(
                                '0', 
                              )
                                  
                            ],
                          ),
                        ),
                        new GestureDetector(                          
                          child: new Icon(
                            Icons.star_border,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),

          GestureDetector(
            
            child: Text(
              
              'Ubicacion:\n${ubicacion}',
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
                color: Colors.white,
              ),
            ),
            onTap: () async {
              await launchUrl(Uri.parse('https://www.google.com/maps/search/?api=1&query=${latitud}%2C${longitud}'));
            },
          )
          ,

          new Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
          new Row(
            
            children: <Widget>[
              new InkWell(
                child: new Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white,
                    ),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(imageUser),
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(right: 10.0),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    '$name',
                    style: new TextStyle(),
                  ),
                  new Text(
                    '$datetime',
                    style: new TextStyle(),
                  ),
                ],
              ),
            ],
          ),
          new Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
        ],
      ),
    )
  );
}