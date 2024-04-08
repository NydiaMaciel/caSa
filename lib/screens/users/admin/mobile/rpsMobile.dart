import 'package:demo_casa_3/screens/data/rpusersClass.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


class RpsMobile extends StatefulWidget {
  String token;
  RpsMobile({super.key, required this.token});

  @override
  State<RpsMobile> createState() => _RpsMobileState();
}

class _RpsMobileState extends State<RpsMobile> {
  bool sortAscendingPuntos = true;
  bool sortAscendingBoletos = true;
  TextEditingController ctrl_query = new TextEditingController();
  bool iconSearchBarCancel=false;
  late List<Jugadores> allJugadores;
  late List<Jugadores> filteredJugadores;
  bool isLoading = true;

  onSortColumn(int colIndex, bool ascending){
    if(colIndex==1){
      if(ascending){
        filteredJugadores.sort((a,b)=>a.totalClientsReferred.compareTo(b.totalClientsReferred));
      }else{
        filteredJugadores.sort((a,b)=>b.totalClientsReferred.compareTo(a.totalClientsReferred));
      }
    }
  }
  @override
  void initState() {
    super.initState();
    fetchJugadores();
  }

  List<Jugadores> filter (String query){
    final filtrados = allJugadores.where((element) {
      String lowerName = element.userName.toLowerCase();
      String lowerQuery = query.toLowerCase();
      return lowerName.contains(lowerQuery);
    }).toList();
    return filtrados;
  }

  Future<void> fetchJugadores()async{
    var jsonlist = await Services().getAllJugadores(widget.token);
    List<Jugadores> tmp=[];
    if(jsonlist.length>0){
      for (var item in jsonlist){
        tmp.add(Jugadores.fromJson(item));
      }
      setState(() {
        allJugadores=tmp;
        filteredJugadores=tmp;
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          //buscador
          Container(
            margin:const EdgeInsets.all(10),
            height: 50,
            child: TextField(
              controller: ctrl_query,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                labelStyle: const TextStyle(fontSize: 5),
                prefixIcon: const Icon(Icons.search,size: 25,),
                suffixIcon: iconSearchBarCancel? IconButton(
                  icon: Icon(iconX,size: 17,),
                  onPressed: (){
                    setState(() {
                      ctrl_query.text="";
                      filteredJugadores=allJugadores;
                      iconSearchBarCancel=false;
                    });
                  },
                ):null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 255, 112, 193)),
                ),
              ),
              onChanged: (value){
                setState(() {
                  if(value==""){
                    filteredJugadores=allJugadores;
                    iconSearchBarCancel=false;
                  }else{
                    iconSearchBarCancel=true;
                    filteredJugadores=filter(value);
                  }
                });
              },
            ),
          ),
          //Lista
          Container(
            height: MediaQuery.of(context).size.height*0.83,
            child: ListView.builder(
              itemCount: filteredJugadores.length,
              itemBuilder: (context,index){
                return ExpansionTile(
                  iconColor: color6,
                  title: Text(filteredJugadores[index].userName,style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),),
                  children: [
                    Row(children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.30,
                        child: ListTile(
                          title: const Text('Boletos', style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                          subtitle: Text(filteredJugadores[index].totalClientsReferred.toString(),style: TextStyle(fontSize: 17),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.43,
                        child: ListTile(
                          title: const Text('Clientes referidos', style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                          subtitle: Text(filteredJugadores[index].totalClientsReferred.toString(),style: TextStyle(fontSize: 17),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        child: ListTile(
                          title: const Text('Puntos', style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                          subtitle: Text(filteredJugadores[index].totalClientsReferred.toString(),style: TextStyle(fontSize: 17),),
                        ),
                      ),
                    ],),
                    const Divider(indent: 20, endIndent: 20,),
                    VerticalDivider(
                          thickness: 5.0,
                          width: 2,
                          color: Colors.grey[700],
                        ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.30,
                          child: ListTile(
                            title: const Text('Telefóno', style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                            subtitle: Text(filteredJugadores[index].phoneNumber,style: TextStyle(fontSize: 17),),
                          ),
                        ),
                        
                        Container(
                          width: MediaQuery.of(context).size.width*0.50,
                          child: ListTile(
                            title: const Text('Correo', style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                            subtitle: Text(filteredJugadores[index].email,style: const TextStyle(fontSize: 17),),
                          ),
                        ),

                      ],
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
}