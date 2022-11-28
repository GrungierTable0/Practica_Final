import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/provider/about_us_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AboutUsProvider(),
      child: AboutUsScreenWidget(),
    );
  }
}

class AboutUsScreenWidget extends StatefulWidget {
  const AboutUsScreenWidget({super.key});

  @override
  State<AboutUsScreenWidget> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreenWidget> {
  final controllerPage=PageController();
  

  @override
  Widget build(BuildContext context) {
    AboutUsProvider lastPage = Provider.of<AboutUsProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => AboutUsProvider(),
      child: Scaffold(
        
        appBar: AppBar(
          title: Text(
            'Sobre Nosotros',
            style: GoogleFonts.acme(
              fontSize:25
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 60),
          child: PageView(
            controller: controllerPage,
            onPageChanged: (index) {
              lastPage.setLastPageData(index==3);
            },
    
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    Text(
                      'Información Personal',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.courgette(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Mi nombre es Juan Pablo Jaramillo Nieto.\nSoy estudiante de la carrera de INGENIERIA EN SISTEMAS COMPUTACIONALES\n',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 105,
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage('assets/creator.jpg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Actualmente estoy cursando Programacion Móvil y Servicios en la Nube en el Tecnologico Nacional de Mexico Campus Celaya\n\nEsta es la practica 7: Firebase',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.indieFlower(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    
                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    Text(
                      'Problematica',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.courgette(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Los perros callejeros en México siguen siendo parte del paisaje urbano y rural. El número de perros callejeros ha ido en aumento en los últimos años en el territorio mexicano. Alrededor de 25 millones de perros viven en las calles de la Ciudad de México. Esto es más que en el resto de Latinoamérica.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),
                    Image(
                      height: 250,
                      image: AssetImage('assets/dog-page2.gif')
                    ),
                    Text(
                      'México tiene la mayor cantidad de perros callejeros en toda América Latina. El Instituto Nacional de Estadística y Geografía (INEGI) estima que alrededor del 70% de los perros en México viven en la calle.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Objetivo General',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.courgette(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'El objetivo de este proyecto es reducir la cantidad de perros que existen en la calle, ayudando a localizarlos si se llegaron a perder, todo esto mediante el desarrollo de una aplicación móvil, mediante el SDK de flutter y con lenguaje dart, que simulara el comportamiento de una red social.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Row(
                      children: [
                        Image(
                          height: 150,
                          image: AssetImage('assets/logo.png')
                        ),
                        Image(
                          height: 150,
                          image: AssetImage('assets/FD-page3.png')
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text(
                      'Es importante aclarar que se necesita que las personas tengan en mente que esta herramienta es exclusivamente para la localización de perros perdidos y no como un juego para subir cualquier cosa. ',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    Text(
                      'Alcance',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.courgette(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Esta aplicación finalizará en una versión funcionable, que sea capaz de la utilización de distintos servicios en la nube mediante la herramienta de FireBase: dentro de los cuales se encuentran: \n-Storage\n-Notificaciones\n-Autentificación\n-Servicio de Base de Datos.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),
                    Image(
                      height: 150,
                      image: AssetImage('assets/Firebase-page4.png')
                    ),
                    Text(
                      'Una gran limitante es que esta red social no va a reconocer las imágenes, lo cual es posible que las personas hagan mal uso de ella, en futuras versiones se podría implementar un algoritmo de Inteligencia artificial que pueda reconocer perros en imágenes y se pueda publicar con esta restricción.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.indieFlower(
                        fontSize: 20,
                      ),
                    ),



                  ]
                ),
              ),
            ],
          ),
        ),
        bottomSheet:lastPage.isLastPage?
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
            ),
            primary: Colors.white,
            backgroundColor: Theme.of(context).backgroundColor,
            minimumSize: const Size.fromHeight(60)
          ),
          child: Text('Regresar!!!',style: GoogleFonts.courgette(fontSize: 24)),
          onPressed:(){
            Navigator.pop(context);
          },        
        )
        : 
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('SKIP'),
                onPressed: () {
                  controllerPage.previousPage(
                    duration: const Duration(microseconds: 500), 
                    curve: Curves.easeInOut
                  );
                },
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controllerPage, 
                  count: 4,
                  effect: WormEffect(
                    spacing: 16,
                    
                    dotColor: Colors.black26,
                    activeDotColor: Theme.of(context).backgroundColor
                  ),
                  onDotClicked: ((index) {
                    controllerPage.animateToPage(
                      index, 
                      duration: const Duration(milliseconds: 500), 
                      curve: Curves.easeIn
                      );
    
                  }),
                ),
              ),
              TextButton(
                child: const Text('NEXT'),
                onPressed: (() {
                  controllerPage.nextPage(
                    duration: const Duration(microseconds: 500), 
                    curve: Curves.easeInOut
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}