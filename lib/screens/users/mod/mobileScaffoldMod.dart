import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/login.dart';
import 'package:demo_casa_3/screens/generals/settings.dart';
import 'package:demo_casa_3/screens/users/admin/mobile/transactions.dart';
import 'package:demo_casa_3/screens/users/mod/transactions.dart';
import 'package:demo_casa_3/screens/users/scanner.dart';
import 'package:demo_casa_3/screens/users/mod/homeMD.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class mobileScaffoldMod extends StatefulWidget {
  Moderators user;
  Sesion dataSesion;
  int pag;
  
  mobileScaffoldMod({super.key, required this.user, required this.dataSesion, this.pag=0});

  @override
  State<mobileScaffoldMod> createState() => _mobileScaffoldModState();
}


class _mobileScaffoldModState extends State<mobileScaffoldMod> {
  late Widget bodyPage; 
  String tituloAppBar = ""; 
  Color hoverDrawerItem = appBarcolorx;
  List<Moderators> allModerators=[];
  
  @override
  void initState(){
    super.initState();
    if(widget.pag!=0){
      switch(widget.pag){
        case 1:
          tituloAppBar="Escanear QR";
          bodyPage=Scanner(usuario: widget.user,dataSesion: widget.dataSesion);
          break;
        case 2:
          tituloAppBar="Mis transacciones";
          bodyPage=TransactionsMD(token: widget.dataSesion.token, usuario: widget.user,);
          break;
        case 3:
          tituloAppBar="Preferencias";
          bodyPage=Settings(usuario: widget.user, dataSesion: widget.dataSesion,);
          break;
      }
    }else{
      tituloAppBar="";
      bodyPage=HomeMD();
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(tituloAppBar),backgroundColor: appBarcolor,),
      drawer: Container(
        height: MediaQuery.of(context).size.height*0.8,
        child: Drawer(    
          width: 250,
          backgroundColor: appBarcolor,
          
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                    leading:Icon(FontAwesomeIcons.userLarge),
                    title: Text(widget.user.userName, style: TextStyle(
                      fontSize: 18,
                    ),),
                    textColor: color6,
                    iconColor: color6,
                    subtitle: Text(widget.user.email,style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                hoverColor: hoverDrawerItem,
                onTap: () {
                  setState(() {
                    tituloAppBar="";
                    bodyPage=HomeMD();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(iconScanQR),
                title: const Text('Escanear QR'),
                hoverColor: hoverDrawerItem,
                onTap: () {
                  setState(() {
                    tituloAppBar="Escanear QR";
                    bodyPage=Scanner(usuario: widget.user,dataSesion: widget.dataSesion);
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(iconJugadores),
                title: const Text('Mis transacciones'),
                hoverColor: hoverDrawerItem,
                onTap: () {
                  setState(() {
                    tituloAppBar="Mis transacciones";
                    bodyPage=TransactionsMD(token: widget.dataSesion.token, usuario: widget.user,);
                  });
                  Navigator.of(context).pop();
                }, 
              ),
              ListTile(
                leading: Icon(iconSettings),
                title: const Text('Preferencias'),
                hoverColor: hoverDrawerItem,
                onTap: () {
                  setState(() {
                    tituloAppBar="Preferencias";
                    bodyPage=Settings(usuario: widget.user, dataSesion: widget.dataSesion,);
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading:Icon(iconSalir),
                title: const Text('Salir'),
                hoverColor: hoverDrawerItem,
                onTap: () {
                  setState(() {
                    showDialog(context: context, 
                      builder: (_)=> AlertDialog(
                        title: const Text('Cerrar Sesión'),
                        content: const Text('¿Está seguro que desea cerrar la sesión?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Confirmar',style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color6)),
                            onPressed: (){
                              Navigator.pop(context, 'OK');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                            },
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context, 'Cancel');
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar',style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: bodyPage,
    );
  }
}