import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/screens/generals/login.dart';
import 'package:demo_casa_3/screens/generals/settings.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/analitcs.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/transactions.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/rps.dart';
import 'package:demo_casa_3/screens/users/mod/homeMD.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/mods.dart';
import 'package:demo_casa_3/screens/users/scanner.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';


class DesktopScaffold extends StatefulWidget {
  Moderators usuario;
  Sesion dataSesion;
  DesktopScaffold({super.key, required this.usuario, required this.dataSesion});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  var selectedPage = 0;
  static const int caseCerrarSesion = 7;
  TextStyle LabelStyle = TextStyle(fontWeight: FontWeight.w400);
  bool disableDestination=true;
  Color destinationIcon = Color.fromARGB(255, 133, 138, 137);
  Color destinationIconSelected = Color.fromARGB(255, 33, 122, 112);
  @override
  Widget build (BuildContext context){    
    Widget page = Placeholder();

    switch (selectedPage){
      case 0: //HOME
        page = HomeMD();
        break;
      case 1://Scan QR
        page= Placeholder();
        break;
      case 2://MODS
        page = ModeradoresMD();
        break;
      case 3://JUGADORES
        page= JugadoresMD();
        break;
      case 4://ANALITICOS
        page = Analitics();
        break;
      case 5: //PRODUCTOS
        page = ProductosTab();
        break;
      case 6: //PREFERENCIAS
        page = Settings(usuario: widget.usuario,dataSesion:widget.dataSesion);
        break;
      case caseCerrarSesion://CERRAR SESION
        break;
      default:
        throw UnimplementedError('no widget for $selectedPage');
    }

    return LayoutBuilder(
      builder: (context, constraints){
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: 
                NavigationRail (
                  labelType: NavigationRailLabelType.all,
                  //extended: constraints.maxWidth >= 1200,
                  //minWidth: 70,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(iconHome,color:destinationIcon),
                      selectedIcon: Icon(iconHome,color:destinationIconSelected),
                      label: Text('Inicio',style: LabelStyle),
                    ),
                    NavigationRailDestination(
                      disabled: disableDestination,
                      icon: disableDestination? Icon(iconScanQR,color:const Color.fromARGB(255, 177, 177, 177)):Icon(iconScanQR,color:destinationIcon), 
                      selectedIcon: Icon(iconScanQR,color:destinationIconSelected),
                      label: Text('Escanear QR',style: LabelStyle),
                    ),
                    
                    NavigationRailDestination(
                      icon: Icon(iconMods,color:destinationIcon), 
                      selectedIcon: Icon(iconMods,color:destinationIconSelected),
                      label: Text('Moderadores',style: LabelStyle),
                      disabled: false,  // administrar permisos de mods
                    ),
                    NavigationRailDestination(
                      icon: Icon(iconJugadores,color:destinationIcon),
                      selectedIcon: Icon(iconJugadores,color:destinationIconSelected), 
                      label: Text('Jugadores',style: LabelStyle),
                    ),
                    NavigationRailDestination(
                      icon: Icon(iconBarrchart,color:destinationIcon),
                      selectedIcon: Icon(iconBarrchart,color:destinationIconSelected), 
                      label: Text('Analíticos',style: LabelStyle),
                    ),
                    NavigationRailDestination(
                      icon: Icon(iconProducts,color:destinationIcon), 
                      selectedIcon: Icon(iconProducts,color:destinationIconSelected),
                      label: Text('Productos',style: LabelStyle),
                    ),
                    NavigationRailDestination(
                      icon: Icon(iconSettings,color:destinationIcon), 
                      selectedIcon: Icon(iconSettings,color:destinationIconSelected),
                      label: Text('Preferencias',style: LabelStyle),
                    ),
                    NavigationRailDestination(
                      icon: Icon(iconSalir,color:destinationIcon), 
                      selectedIcon: Icon(iconSalir,color:destinationIconSelected), 
                      label: Text('Cerrar Sesión',style: LabelStyle),
                    ),
                  ],
                  selectedIndex: selectedPage,
                  onDestinationSelected: (value) {
                    setState(() {
                      var anterior = selectedPage;
                      selectedPage = value;
                      if (value==caseCerrarSesion){
                        selectedPage=anterior;
                        showDialog(context: context, 
                        barrierDismissible: false,
                          builder: (_)=> AlertDialog(
                            title: const Text('Cerrar Sesión'),
                            content: const Text('¿Está seguro que desea cerrar la sesión?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context, 'Cancel');
                                  setState(() {
                                    selectedPage = anterior;
                                  });
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context, 'OK');
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                                },
                                child: const Text('Si'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  },                  
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 230,204,179),
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}