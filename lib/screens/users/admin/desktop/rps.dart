import 'package:demo_casa_3/screens/data/rpusersClass.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/transRp.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:flutter/material.dart';

//
TextEditingController ctrl_nombre = new TextEditingController();
TextEditingController ctrl_query = new TextEditingController();
bool iconSearchBarCancel=false;
bool flag_permiso1 = false;
bool flag_permiso2 = false;
bool flag_permiso3 = false;
bool flag_permiso4 = false;
bool flag_permiso5 = false;

class JugadoresMD extends StatefulWidget {
  String token;
  JugadoresMD({super.key,required this.token});

  @override
  State<JugadoresMD> createState() => _JugadoresMDState();
}

class _JugadoresMDState extends State<JugadoresMD> {
  bool sortAscending = true;
  bool editflag = false;
  bool isLoading = true;
  bool errorHttp = false;
  int selectedPanel = -1;
  Color tileSelectedColor = Colors.white;
  Color checkColor = Color.fromARGB(255, 51, 72, 135);
  Color colorPanelEmpty = Color.fromARGB(255, 225, 224, 224);
  late List<Jugadores> allJugadores;
  late List<Jugadores> filteredJugadores;
  late Widget userDataPanel;
  String errorAdvice='';
  double drawerSize = 250;
  bool showPanel = false;
  Icon openPanel = Icon(Icons.arrow_forward_ios,size: 17,color: color1);
  Icon closePanel = Icon(Icons.arrow_back_ios,size: 17,color: color6);

  onSortColumn(int colIndex, bool ascending){
    if(colIndex==0){
      if(ascending){
        //lista.sort((a,b)=>a.nombre.compareTo(b.nombre));
      }else{
        //lista.sort((a,b)=>b.nombre.compareTo(a.nombre));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJugadores();
    userDataPanel=Container();
  }

  List<Jugadores> filter (String query){
    final cards = allJugadores.where((element) {
      String lowerName = element.userName.toLowerCase();
      String lowerQuery = query.toLowerCase();
      return lowerName.contains(lowerQuery);
    }).toList();
    return cards;
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
      return Scaffold(
        body: Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 3,strokeAlign: 5,),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              color: colorPanelEmpty,
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width-drawerSize,
        child: Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              child: Column(
                children: [
                  buscador(),
                  Container(
                    height: MediaQuery.of(context).size.height-70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 0.8, color: appBarcolorx,),
                        top: BorderSide(width: 0.5, color: Colors.grey,)
                      ),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredJugadores.length,
                      itemBuilder:(context,index){
                        return ListTile(
                          title: Text(filteredJugadores[index].userName),
                          hoverColor: colorPanelEmpty,
                          splashColor: color24,
                          tileColor: selectedPanel==index?colorPanelEmpty:Colors.white,

                          trailing: (showPanel==true && selectedPanel==index)?closePanel:openPanel,
                          onTap: () {
                            setState(() {
                              showPanel=!showPanel;
                              if(showPanel==true){
                                selectedPanel = index;
                                userDataPanel = tabView(filteredJugadores[index]);
                              }else{
                                selectedPanel = -1;
                                userDataPanel = Container();
                              }
                            });
                          },
                        );
                      }, 
                    ),
                  ),                  
                ],
              ),
            ),
            Container(
              //height: MediaQuery.of(context).size.height*0.5,
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              color: colorPanelEmpty,
              child: userDataPanel,
            ),
          ],
        ),
      ),
    );
  }

  Widget tabView(Jugadores mod){
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: color6,
            labelColor: color6,
            tabs: [
              Tab(text: 'Datos Personales'),
              Tab(text: 'Transacciones'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contenido de la pestaña 1
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('Invitados: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.totalClientsReferred.toString(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('Nombre: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.userName, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('Teléfono: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.phoneNumber, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('Correo: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.email, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  ////
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('ID: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.id.toString(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  ///////////
                  Divider(height: 50,),
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.bottomRight,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 209, 203)),
                      ),
                      child: Text('Eliminar',style: TextStyle(color: Color.fromARGB(255, 221, 47, 35)),),
                      onPressed: ()async{
                        var response = await Services().deleteMod(mod.id, widget.token);
                        fetchJugadores();
                      }, 
                    ),
                  ),
                ]
              ),
            ),
            // Contenido de la pestaña 2
            Center(
              child: TransRp(usuario: mod, token: widget.token),
            ),
          ],
        ),
      ),
    );
  }

  Widget buscador(){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.all(15),
        height: 30,
        child: TextField(
          controller: ctrl_query,
          style: TextStyle(fontSize: 15),
          cursorColor: color1,
          cursorHeight: 23,
          cursorWidth: 1.0,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            prefixIcon: const Icon(Icons.search,size: 20,),
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
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: color1, width: 1.0), // Borde en foco en gris
            ),
          ),
          onChanged: (value) {
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
    );
  }

}