import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/settings.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';

class SetingsLayout extends StatelessWidget {
  Moderators usuario;
  Sesion dataSesion;
  SetingsLayout({super.key,required this.usuario, required this.dataSesion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPanelEmpty,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width/2,
          child: Settings(usuario: usuario, dataSesion: dataSesion),
        ),
      ),
    );
  }
}