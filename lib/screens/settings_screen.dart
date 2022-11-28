import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/user_model.dart';
import 'package:proyecto_final/provider/theme_provider.dart';
import 'package:proyecto_final/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return SettingsScreenWidget(userModel: userModel,);
    
  }
}

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreenWidget> {
  
  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.settings,
            size: 40,
          )
        ],
        title: Text(
          'Configuracion',
          style: GoogleFonts.acme(
            fontSize:25
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
             'Perfil',
             textAlign: TextAlign.left,
             style: GoogleFonts.courgette(
              fontSize: 30,
             ),  
            ),
            Text(
              'Esta es la informacion de de tu perfil',
              style: GoogleFonts.indieFlower(
                fontSize: 20
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            widget.userModel.idUser==null? //esperando a loggin
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, '/login');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,  
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).backgroundColor,
                      spreadRadius: 3,
                      
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    'Inicia sesion',
                    style: GoogleFonts.permanentMarker(
                      fontSize: 20,
                      
                    ),
                  )
                ),
              ),
            ) 
            : 
            Text(
              'Tu id: \n${widget.userModel.idUser} \n\nCorreo: ${widget.userModel.emailUser}\n\nEstas loogeado con el proveedor: ${widget.userModel.proveedorUser}',
              style: GoogleFonts.indieFlower(
                fontSize: 20
              ),
            ),
            
            Divider(
              color: Theme.of(context).backgroundColor,
              height: 50,             
            ),
            Text(
              'Conoce sobre nosotros!!',
              textAlign: TextAlign.left,
              style: GoogleFonts.courgette(
                fontSize: 30,
              ),  
            ),
            Text(
              'Conoce toda la informacion sobre este proyecto de moviles',
              style: GoogleFonts.indieFlower(
                fontSize: 20
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/aboutus');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,  
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).backgroundColor,
                      spreadRadius: 3,
                      
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    'Sobre nosotros !!',
                    style: GoogleFonts.permanentMarker(
                      fontSize: 20,
                      
                    ),
                  )
                ),
              ),
            ),


            

            Divider(
              color: Theme.of(context).backgroundColor,
              height: 50,             
            ),
            Text(
              'Selecciona el Tema de tu preferencia',
              textAlign: TextAlign.center,
              style: GoogleFonts.courgette(
                fontSize: 30,
              ),  
            ),
            TextButton.icon(
              onPressed: () async {
                tema.setthemeData(temaDia());
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('theme', 1);
              },
              icon: Icon(Icons.brightness_1),
              label: Text('Tema de Día'),
            ),
            TextButton.icon(
              onPressed: () async {
                tema.setthemeData(temaNoche());
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('theme', 2);
              },
              icon: Icon(Icons.dark_mode),
              label: Text('Tema de Noche'),
            ),
            TextButton.icon(
              onPressed: () async {
                tema.setthemeData(temaCalido());
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('theme', 3);
              },
              icon: Icon(Icons.hot_tub_sharp),
              label: Text('Tema Calido'),
            ),



            

          ],
        ),
      ),
    );
    
  }
}