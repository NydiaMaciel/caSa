import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Recup extends StatefulWidget {
  @override
  _RecupState createState()=> _RecupState();
}

class _RecupState extends State <Recup>{
  TextEditingController ctrl_user = new TextEditingController();
  TextEditingController ctrl_email = new TextEditingController();
  @override
  Widget build (BuildContext context){
    double MQwidth = MediaQuery.of(context).size.width;
    //print('$MQwidth');
    bool responsive_ = MQwidth<1100;
    double sizeicon = 17;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [BGgradLoginSUP,BGgradLoginINF],
            )
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Recuperar Contraseña",
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive_?30:40,
                  fontFamily: 'Wenstern',
                  fontWeight: FontWeight.bold,
                  color: iconColorForm,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: responsive_?MQwidth*0.85:MQwidth*0.50,
                padding: EdgeInsets.all(responsive_?20:30),
                  decoration: BoxDecoration(
                    color: BGform,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Text('Ingrese su usuario y correo electrónico, se enviará un correo de recuperación.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: BGgradLoginSUP,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Vintage Avalanche'
                      ),),
                      TextFormField(
                        controller: ctrl_user,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          suffixIcon: Icon(iconUsuario, size:responsive_?13:sizeicon,color: iconColorForm,),
                          enabled: true,
                        ),
                        validator: (value) {
                          if(value!.length == 0){
                            return "Ingrese su nombre de usuario";
                          }
                        },
                      ),
                      TextFormField(
                        controller: ctrl_email,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          suffixIcon: Icon(iconArroba, size:responsive_?13:sizeicon,color: iconColorForm,),
                          enabled: true,
                        ),
                        validator: (value) {
                          if(value!.length == 0){
                            return "Ingrese su correo electrónico";
                          }
                        },
                      ),
                    ],
                  ),
              ),
              SizedBox(height: 20,),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: fucsia,
                  padding: EdgeInsets.symmetric(vertical:15.0, horizontal:50.0),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                },  
                child: const Text('enviar', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Wenstern',
                  fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ), 
          
          
          
          
          
          
        ),
      ),
    );
  }
}