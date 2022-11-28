
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/user_model.dart';
import 'package:proyecto_final/provider/feed_provider.dart';
import 'package:proyecto_final/screens/breeds_screen.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/profile_screen.dart';
import 'package:proyecto_final/screens/settings_screen.dart';
import 'package:proyecto_final/screens/suscription_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedProvider(),
      child: FeedScreenWidget(),
    );
  }
}

class FeedScreenWidget extends StatefulWidget {
  const FeedScreenWidget({super.key});

  @override
  State<FeedScreenWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreenWidget> {
  UserModel user= UserModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FeedProvider _screenIndex = Provider.of<FeedProvider>(context);
    if(ModalRoute.of(context)!.settings.arguments != null){
      user = ModalRoute.of(context)!.settings.arguments as UserModel;
    }
    
    final List _screens = [
      {"screen": HomeScreen(userModel: user,)},
      {"screen": SuscriptionScreen(userModel: user)},
      {"screen": BreedsScreen(userModel: user)},
      {"screen": ProfileScreen(userModel: user)},
      {"screen": SettingsScreen(userModel: user,)}
      
    ];
    return Scaffold(
      
      body: _screens[_screenIndex.getIndexData()]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _screenIndex.getIndexData(),
        onTap:(value) {
          _screenIndex.setIndexData(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.insert_emoticon), label: 'Suscripcion'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Razas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Conf")
        ],
      ),
      
    );    
  }
}


