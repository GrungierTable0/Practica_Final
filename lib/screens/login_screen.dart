
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/form_validator.dart';
import 'package:proyecto_final/models/user_model.dart';
import 'package:proyecto_final/provider/login_provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: LoginScreenWidget(),
    );
  }
}

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreenWidget> {
  static const _durations = [5000];
  static const _heightPercentages = [0.12];
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  
  String emaiT="",passT="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FacebookAuth.instance.logOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider _obscureText = Provider.of<LoginProvider>(context);
    var colors = [
      Theme.of(context).cardColor,
    ];
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        
        body: Stack(
          children: [
            WaveWidget(
              config: CustomConfig(
                  colors: colors,
                  durations: _durations,
                  heightPercentages: _heightPercentages,
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              size: Size(double.infinity, double.infinity),
              waveAmplitude: 0, 
            ),
            
    
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Text(
                        'Bienvenido',
                        style: GoogleFonts.lobster(
                          fontSize: 40,
                          color: Colors.white
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Container(
                      height: 170,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'correo@email.com',
                              labelText: 'Correo',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                            validator: FormValidator().validateEmail,
                            
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          TextFormField(
                            controller: txtPass,
                            autofocus: false,
                            obscureText: _obscureText.getOscureData(),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              labelText: 'Contraseña',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _obscureText.setOscureData(!_obscureText.getOscureData());
                                },
                                child: Icon(
                                  _obscureText.getOscureData() ? Icons.visibility : Icons.visibility_off,
                                  semanticLabel:
                                      _obscureText.getOscureData() ? 'show password' : 'hide password',
                                ),
                              ),
                            ),
                            validator: FormValidator().validatePassword,
                          ),
                          
                        ],
                         
                      ),
                      
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aun no tienes cuenta? ',
                          style: TextStyle(
                            color: Colors.black
                          )
                        ),
                        GestureDetector(
                          child: Text(
                            'Regristrate ahora',
                            style: TextStyle(
                              color: Colors.blue
                            )
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      child: GestureDetector(
                        onTap: () async{
                          emaiT=txtEmail.text;
                          passT=txtPass.text;
                          if("".compareTo(txtEmail.text)==0||"".compareTo(txtPass.text)==0){
                            
                            
                          }else{
                            try{
                              var ban =await FirebaseAuth.instance.signInWithEmailAndPassword(email: emaiT, password: passT);
                              if (ban.user!.uid !=null){
                                if(FirebaseAuth.instance.currentUser!.email!=null){
                                  await ProgressDialog.future(
                                    context, 
                                    future: Future.delayed(Duration(seconds: 1), () {
                                      return "";
                                    }),
                                    message: Text("Please Wait"),
                                    title: Text("Loging in"),
                                  );
                                  UserModel userModel = new UserModel(
                                    idUser: FirebaseAuth.instance.currentUser!.uid,
                                    imageUser: 'https://support.pega.com/sites/default/files/pega-user-image/460/REG-459913.png',
                                    nameUser: 'Amigo',
                                    emailUser: FirebaseAuth.instance.currentUser!.email,
                                    proveedorUser: 'Correo y Contraseña',
                                  );
                                  Navigator.popAndPushNamed(context, '/feed',arguments: userModel);
                
                                }else{
                                  AlertDialog(
                                    title: Text('ERROOR!!'),
                                    content: Text('El correo no es valido'),
                                    actions: <Widget>[
                                      TextButton( child: Text('Aceptar'),onPressed: () {
                                        Navigator.pop(context);
                                      },)
                                    ],
                                  ).show(context);
                                }
                
                              }else{
                                AlertDialog(
                                  title: Text('ERROOR!!'),
                                  content: Text('Credenciales no validas'),
                                  actions: <Widget>[
                                    TextButton( child: Text('Aceptar'),onPressed: () {
                                      Navigator.pop(context);
                                    },)
                                  ],
                                ).show(context);
                              }
                            }catch(e){
                              print(e);
                            }
                            
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,  
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                
                                fontSize: 30,
                                color: Colors.white
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Column(
                        children: [
                          SocialLoginButton(
                            buttonType: SocialLoginButtonType.facebook,
                            onPressed: () async {    
                              LoginResult result = await FacebookAuth.instance.login(); 
                              if (result.status == LoginStatus.success) {
                                AccessToken? token = await FacebookAuth.instance.accessToken;
                                final userData = await FacebookAuth.instance.getUserData();
                                
                                final credential = FacebookAuthProvider.credential(token!.token);
                                final user= await FirebaseAuth.instance.signInWithCredential(credential);
                                UserModel userModel = new UserModel(
                                  idUser: user.user!.uid,
                                  imageUser: userData['picture']['data']['url'],
                                  nameUser: userData['name'],
                                  emailUser: userData['email'],
                                  proveedorUser: 'Facebook',
                                );
                                Navigator.popAndPushNamed(context, '/feed',arguments: userModel);
                                
                              } 
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)
                          ),
                          SocialLoginButton(
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () async {
                              final googleSignIn = GoogleSignIn(scopes: ["email"]);
                              try{
                                final googleSignInAccount = await googleSignIn.signIn();
                                if(googleSignInAccount != null){
                                  final googleSignInAuthentication=await googleSignInAccount.authentication;
                                
                                  final credential = GoogleAuthProvider.credential(
                                    accessToken: googleSignInAuthentication.accessToken,
                                    idToken: googleSignInAuthentication.idToken
                                  );
                                  
                                  FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                                    
                                    if(value.user!.email!=null){
                                      UserModel userModel = new UserModel(
                                        idUser: value.user!.uid,
                                        imageUser: value.user!.photoURL,
                                        nameUser: value.user!.displayName,
                                        emailUser: value.user!.email,
                                        proveedorUser: 'Google',
                                      );
                                      Navigator.popAndPushNamed(context, '/feed',arguments: userModel);
                                    }else{
                                      
                                      AlertDialog(
                                        title: Text('ERROOR!!'),
                                        content: Text('El correo no es valido o no se ha validado'),
                                        actions: <Widget>[
                                          TextButton( child: Text('Aceptar'),onPressed: () {
                                            Navigator.pop(context);
                                          },)
                                        ],
                                      ).show(context);
                                    }
                                  });
                                }
                              } catch(e){
                                print(e);
                              }
                            },
                          ),Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)
                          ),
                          SocialLoginButton(
                            buttonType: SocialLoginButtonType.github,
                            onPressed: () async {
                              
                            },
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-60,right: 15,top: 50),
              child: FloatingActionButton(
                child: Icon(Icons.settings),
                onPressed:() {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ),
          ],         
        ),
      ),
    );
  }
}