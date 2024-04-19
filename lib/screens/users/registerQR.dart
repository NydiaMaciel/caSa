import 'dart:developer';

import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/data/rpusersClass.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/users/admin/mobile/mobileScaffold.dart';
import 'package:demo_casa_3/screens/users/mod/mobileScaffoldMod.dart';
import 'package:demo_casa_3/screens/users/scanner.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:core';


class RegisterQR extends StatefulWidget {
  Sesion dataSesion;
  Moderators usuario;
  String code;
  RegisterQR({required this.code,required this.usuario, required this.dataSesion});

  @override
  State<RegisterQR> createState() => _RegisterQRState();
}

class _RegisterQRState extends State<RegisterQR> {
  int cont=0;
  bool _presionando = false;
  double buttonheight = 70;
  Color buttonColor = fucsiaTonalDark;
  late int idQR;
  late Jugadores rpEscaneado;

  @override
  void initState(){
    super.initState();
    setState(() {
      idQR = int.parse(widget.code);//getIdInQrCode(widget.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [BGgradLoginSUP,BGgradLoginINF],
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Registrar invitados',style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 50,),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                color: BGform,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(idQR.toString(), 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: (){
                    setState(() {
                      if(cont>0){
                        cont--;
                      }
                    });
                  },
                  onLongPress: () {
                    _presionando = true;
                    _DecrementoContinuo();
                  },
                  onHighlightChanged: (isHighlight) {
                    if (!isHighlight) {
                      _presionando = false;
                    }
                  },
                  child: Icon(Icons.remove),
                  height: buttonheight,
                  color: cont>0?buttonColor:Colors.grey,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: buttonheight,
                  color: Colors.white70,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('$cont',
                    style: TextStyle(fontSize: 40),
                  ),
                  
                ),
                MaterialButton(
                  onPressed: (){
                    setState(() {
                        cont++;
                    });
                  },
                  onLongPress: () {
                    _presionando = true;
                    _AumentoContinuo();
                  },
                  onHighlightChanged: (isHighlight) {
                    setState(() {
                      if (!isHighlight) {
                        _presionando = false;
                      }else{
                        _presionando=true;
                      } 
                    });
                  },
                  child: Icon(Icons.add),
                  height: buttonheight,
                  color: buttonColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor:cont>0? Color.fromARGB(255,237,39,136):Colors.grey,
                padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0), 
              ),
              
              onPressed: () {  
                if (cont>0){
                  //get:RP.clients_referred
                  
                  getrpEscaneado();
                  //add cont
                  //patch:RP.clients_referred
                  if(widget.dataSesion.type=='administrator'){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mobileScaffold(user: widget.usuario,dataSesion: widget.dataSesion,)));
                  }else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mobileScaffoldMod(user: widget.usuario,dataSesion: widget.dataSesion,)));
                  }
                }
              },  
              child: const Text('Registrar', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
              child: const Text('Cancelar', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700
                ),
              ),

              style: TextButton.styleFrom(
                backgroundColor:Color.fromARGB(255, 125, 125, 125),
                padding: EdgeInsets.symmetric(vertical:10.0, horizontal:25.0), 
              ),
              
              onPressed: () {
                setState(() {
                  if(widget.dataSesion.type=='administrator'){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mobileScaffold(user: widget.usuario,dataSesion: widget.dataSesion, pag: 1)));
                  }else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mobileScaffoldMod(user: widget.usuario,dataSesion: widget.dataSesion, pag: 1,)));
                  }
                });
              },  
            ),
          ],
        ),
      ),
    );
  }

  void getrpEscaneado()async{
    //idQR
    var usrscn = await Services().getUserById(idQR, widget.dataSesion.token);
    rpEscaneado=usrscn;
  }

  int getIdInQrCode(String texto) {
    print('CODECODECODE:::::: '+texto);
    RegExp regex = RegExp(r"/(\d+)$");
    RegExpMatch? match = regex.firstMatch(texto);
    if (match != null) {
      String numero = match.group(1)!;
      return int.parse(numero);
    } else {
      print("");
    }
    return -1;
  }

  void _AumentoContinuo() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_presionando) {
        setState(() {
          cont++;
        });
        _AumentoContinuo();
      }
    });
  }

  void _DecrementoContinuo() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_presionando) {
        setState(() {
          if(cont>0){
            cont--;
          }
        });
        _DecrementoContinuo();
      }
    });
  }
}