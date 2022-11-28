
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proyecto_final/models/user_model.dart';

import 'package:proyecto_final/provider/theme_provider.dart';
import 'package:proyecto_final/screens/about_us_screen.dart';
import 'package:proyecto_final/screens/feed_screen.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/login_screen.dart';
import 'package:proyecto_final/screens/settings_screen.dart';
import 'package:proyecto_final/screens/sign_up_screen.dart';
import 'package:proyecto_final/screens/splash_screen.dart';
import 'package:proyecto_final/services/push_notification_service.dart';
import 'package:proyecto_final/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), child: PMSNApp()
    );
  }
}

class PMSNApp extends StatelessWidget {
  PMSNApp({Key? key}) : super(key: key);
  UserModel userModel= UserModel(
    idUser: null
  );
  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    Future getData() async {
      final prefs = await SharedPreferences.getInstance();
      final int? idtheme = prefs.getInt('theme');
      switch(idtheme){
        case 1:
          tema.setthemeData(temaDia());
        break;
        case 2:
          tema.setthemeData(temaNoche());
        break;
        case 3:
          tema.setthemeData(temaCalido());
        break;
        default:
          tema.setthemeData(temaDia());
        break;
      }
    }
    getData();
    return MaterialApp(
      title: 'proyecto_final',
      debugShowCheckedModeBanner: false,
      theme: tema.getthemeData(),
      home:  LoginScreen(),
      routes: {
        '/login': (BuildContext context) => LoginScreen(),
        '/settings': (BuildContext context) => SettingsScreen(userModel: userModel,),
        '/aboutus': (BuildContext context) => AboutUsScreen(),
        '/home': (BuildContext context) => HomeScreen(userModel: userModel,),
        '/feed': (BuildContext context) => FeedScreen(),
        '/signup':(BuildContext context) => SignUpScreen(),
      },
    );
  }
}


