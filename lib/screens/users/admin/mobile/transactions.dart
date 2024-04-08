import 'package:demo_casa_3/screens/data/productosClass.dart';
import 'package:demo_casa_3/screens/data/transaccionesClass.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  String token;
  Transactions({super.key, required this.token});

  @override
  _Transactions createState()=> _Transactions();
}

class _Transactions extends State <Transactions>{
  late List<Transacciones> allTransacciones;
  late List<Transacciones> lista;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrans();
  }
  
  @override
  Widget build (BuildContext context){
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            //color: Colors.blue,
            height: MediaQuery.of(context).size.height*0.02,//0.07,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context,index){
                return ExpansionTile(
                  iconColor: color6,
                  tilePadding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
                  childrenPadding: EdgeInsets.only(top: 0, bottom: 20, right: 20, left: 20),
                  title: Text(lista[index].moderator+' - '+lista[index].rp_user,style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),), 
                  subtitle: Text(getFecha(lista[index].created_date)+'    '+getHora(lista[index].created_date),
                    style: TextStyle(fontSize: 17),
                  ),
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.40,
                          child: ListTile(
                            title: Text('Moderador',style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                            subtitle: Text(lista[index].moderator,style: TextStyle(fontSize: 17),),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.40,
                          child: ListTile(
                            title: Text('Jugador',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            )),
                            subtitle: Text(lista[index].rp_user,style: TextStyle(fontSize: 17),),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text('Clientes referidos',style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                      subtitle: Text(lista[index].clients_referred.toString(),style: TextStyle(fontSize: 17),),
                    ),
                  ], 
                );
              },
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

  Future<void> fetchTrans()async{
    var jsonlist = await Services().getAllTransactions(widget.token);
    List<Transacciones> tmp=[];
    if(jsonlist.length>0){
      for (var item in jsonlist){
        tmp.add(Transacciones.fromJson(item));
      }
      setState(() {
        allTransacciones=tmp;
        lista=tmp;
        isLoading = false;
      });
    }
  }

}
