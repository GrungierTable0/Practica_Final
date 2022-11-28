import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/firebase/email_authentication.dart';
import 'package:proyecto_final/models/form_validator.dart';
import 'package:proyecto_final/provider/login_provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: SingUpScreenWidget(),
    );
  }
}

class SingUpScreenWidget extends StatefulWidget {
  const SingUpScreenWidget({super.key});

  @override
  State<SingUpScreenWidget> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreenWidget> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  EmailAuthentication? _emailAuth;
  static const _durations = [5000];
  
  static const _heightPercentages = [0.12];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailAuth=EmailAuthentication();
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Text(
                      'Registro de Correo',
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
                          autofocus: true,
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        if("".compareTo(txtEmail.text)==0||"".compareTo(txtPass.text)==0){
                          
                          
                        }else{
                          _emailAuth?.createUserWithEmailAndPassword(
                                email: txtEmail.text, password: txtPass.text)
                          .then((value) {
                            if(value){
                              final snackBar =SnackBar(content: Text('Mandamos un Correo de verificación!!'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);
                            }else{
                              final snackBar =SnackBar(content: Text('Ha ocurrido un error, favor de intentarlo mas tarde'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);
                            }
                          });
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
                            'Registrarse',
                            style: TextStyle(
                              
                              fontSize: 30,
                              color: Colors.white
                            ),
                          )
                        ),
                      ),
                    ),
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