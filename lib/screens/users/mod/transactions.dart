import 'dart:async';

import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/data/transaccionesClass.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TransactionsMD extends StatefulWidget {
  String token;
  Moderators usuario;
  TransactionsMD({super.key, required this.token, required this.usuario});

  @override
  State<TransactionsMD> createState() => _TransactionsMDState();
}

class _TransactionsMDState extends State<TransactionsMD> {
  late List<Transacciones> allTransacciones;
  late List<Transacciones> lista;
  bool isLoading = true;
  bool isEmpty = false;
  
  @override
  void initState(){
    super.initState();
    fetchTransMD();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if(isEmpty){
      print('vacio');
      return const Center(
        child: Text('No se han registrado transacciones.', 
        style: TextStyle(fontSize: 20),),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.02,//0.07,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context,index){
                return ExpansionTile(
                  tilePadding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
                  childrenPadding: EdgeInsets.only(top: 0, bottom: 20, right: 20, left: 20),
                  title: Text(lista[index].rp_user, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),), 
                  subtitle: Text(getFecha(lista[index].created_date)+'    '+getHora(lista[index].created_date),
                    style: TextStyle(fontSize: 17),
                  ),
                  children: [
                    ListTile(
                      title: Text('Jugador',style: TextStyle(
                      fontWeight: FontWeight.w600,
                      )),
                      subtitle: Text(lista[index].rp_user,style: TextStyle(fontSize: 17),),
                    ),
                    ListTile(
                      title: Text('Clientes referidos',style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                      subtitle: Text(lista[index].clients_referred.toString(),style: TextStyle(fontSize: 17),),
                    ),
                  ]
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  String getFecha(DateTime date){
    String fecha = '${date.day}/${date.month}/${date.year}';
    return fecha;
  }

  String getHora(DateTime date){
    String hora = '${date.hour}:${date.minute}:${date.second}';
    return hora;
  }

  Future<void> fetchTransMD()async{
    var jsonlist = await Services().getTransactionsModById(widget.token, widget.usuario.id);
    print(jsonlist.length.toString());
    List<Transacciones> tmp=[];
    if(jsonlist.length>0){
      for (var item in jsonlist){
        print(item['rp_user']);
        tmp.add(Transacciones.fromJson(item));
      }
      setState(() {
        allTransacciones=tmp;
        lista=tmp;
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading = false;
        isEmpty=true;
      });
    }
  }

}