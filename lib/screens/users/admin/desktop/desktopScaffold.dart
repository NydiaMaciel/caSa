import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/screens/generals/login.dart';
import 'package:demo_casa_3/screens/generals/settings.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/settingsLayout.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/analitcs.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/transactions.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/rps.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/home.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/mods.dart';
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
  int selectedPage = 0;
  Color normalColorDrawer = color1;
  Color selectedColorText = color19;
  Color selectedColorBG = color23;
  Widget screen = Home();
  double drawerSize = 250;
  
  @override
  Widget build (BuildContext context){    
    Widget page = Placeholder();

    return LayoutBuilder(
      builder: (context, constraints){
        return Scaffold(
          body: Container(
            color: color6,
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                Drawer(
                  width: drawerSize,
                  backgroundColor: appBarcolor,
                  shape: const Border(
                    bottom: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide.none,
                    top: BorderSide.none,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Icon(iconUsuario, color: color6,),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.usuario.userName,style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: color6,
                                ),),
                                SizedBox(height: 3),
                                Text(widget.usuario.email,style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: color6,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
            
                      ListTile(
                        leading: Icon(iconHome,color: selectedPage==0? selectedColorText:normalColorDrawer,),
                        hoverColor: appBarcolor3,
                        tileColor: selectedPage==0?selectedColorBG:appBarcolor,
                        title: Text('Inicio', style: TextStyle(
                          color: selectedPage==0? selectedColorText:normalColorDrawer,
                        ),),
                        onTap: (){
                          setState(() {
                            selectedPage=0;
                            screen= Home();
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.people,color: selectedPage==1? selectedColorText:normalColorDrawer,),
                        hoverColor: appBarcolor3,
                        tileColor: selectedPage==1?selectedColorBG:appBarcolor2,
                        title: Text('Moderadores',style: TextStyle(
                          color: selectedPage==1? selectedColorText:normalColorDrawer,
                        ),),
                        onTap: (){
                          setState(() {
                            selectedPage=1;
                            screen= ModeradoresMD(token: widget.dataSesion.token,);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(iconTroph,color: selectedPage==2? selectedColorText:normalColorDrawer,),
                        hoverColor: appBarcolor3,
                        tileColor: selectedPage==2?selectedColorBG:appBarcolor2,
                        title: Text('Jugadores',style: TextStyle(
                          color: selectedPage==2? selectedColorText:normalColorDrawer,
                        ),),
                        onTap: (){
                          setState(() {
                            selectedPage=2;
                            screen= JugadoresMD(token: widget.dataSesion.token,);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(iconJugadores,color: selectedPage==3? selectedColorText:normalColorDrawer,),
                        hoverColor: appBarcolor3,
                        tileColor: selectedPage==3?selectedColorBG:appBarcolor2,
                        title: Text('Transacciones',style: TextStyle(
                          color: selectedPage==3? selectedColorText:normalColorDrawer,
                        ),),
                        onTap: (){
                          setState(() {
                            selectedPage=3;
                            //screen= ModeradoresMD(token: widget.dataSesion.token,);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(iconSettings,color: selectedPage==4? selectedColorText:normalColorDrawer,),
                        hoverColor: appBarcolor3,
                        tileColor: selectedPage==4?selectedColorBG:appBarcolor2,
                        title: Text('Preferencias',style: TextStyle(
                          color: selectedPage==4? selectedColorText:normalColorDrawer,
                        ),),
                        onTap: (){
                          setState(() {
                            selectedPage=4;
                            screen = SetingsLayout(usuario: widget.usuario, dataSesion: widget.dataSesion);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(iconSalir,color: selectedPage==5? selectedColorText:normalColorDrawer,),
                        hoverColor: appBarcolor3,
                        tileColor: selectedPage==5?selectedColorBG:appBarcolor2,
                        title: Text('Salir',style: TextStyle(
                          color: selectedPage==5? selectedColorText:normalColorDrawer,
                        ),),
                        onTap: (){
                          setState(() {
                            selectedPage=5;
                            showDialog(context: context, 
                              builder: (_)=> AlertDialog(
                                title: const Text('Cerrar Sesión'),
                                content: const Text('¿Está seguro que desea cerrar la sesión?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Confirmar',style: TextStyle(color: Colors.white),),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color6)),
                                    onPressed: (){
                                      //Navigator.pop(context, 'OK');
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Cancelar',style: TextStyle(color: Colors.black),),
                                    onPressed: (){
                                      //Navigator.pop(context, 'Cancel');
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      ),
            
                    ]
                  ),
                ),
                //BODY
                Column(
                  children:[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width-drawerSize,
                      child: screen,
                    )
                  ],
                ),  
              ]
            ),
          ),
        );
      },
    );
  }
}