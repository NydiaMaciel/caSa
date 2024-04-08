import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
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

class ModeradoresMD extends StatefulWidget {
  const ModeradoresMD({super.key});

  @override
  State<ModeradoresMD> createState() => _ModeradoresMDState();
}

class _ModeradoresMDState extends State<ModeradoresMD> {
  bool sortAscending = true;
  bool editflag = false;
  Color checkColor = Color.fromARGB(255, 51, 72, 135);
  late List<Moderators> lista; 

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
  Widget build(BuildContext context) {
    
    double MQwidth = MediaQuery.of(context).size.width;
    bool responsive = MQwidth<1100? true:false;
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(iconAdd),
        elevation:5.0,
        onPressed: (){
          showDialog(
            barrierDismissible: false,
            context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: StatefulBuilder(
                  builder: (BuildContext contex, StateSetter setState){
                    return Container(
                      height:300,
                      width: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: ctrl_nombre,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              labelStyle: TextStyle(fontSize: 14),
                              enabled: true,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children:[
                              Text('Permiso 1'),
                              SizedBox(width: 5,),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                value: flag_permiso1,
                                activeColor: Color.fromARGB(255, 57, 132, 59),
                                onChanged: (value){
                                  setState(() {
                                    flag_permiso1=value;
                                  });
                                }),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children:[
                              Text('Permiso 2'),
                              SizedBox(width: 10,),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                value: flag_permiso2,
                                activeColor: Color.fromARGB(255, 57, 132, 59),
                                onChanged: (value){
                                  setState(() {
                                    flag_permiso2=value;
                                  });
                                }),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children:[
                              Text('Permiso 3'),
                              SizedBox(width: 10,),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                value: flag_permiso3,
                                activeColor: Color.fromARGB(255, 57, 132, 59),
                                onChanged: (value){
                                  setState(() {
                                    flag_permiso3=value;
                                  });
                                }),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children:[
                              Text('Permiso 4'),
                              SizedBox(width: 10,),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                value: flag_permiso4,
                                activeColor: Color.fromARGB(255, 57, 132, 59),
                                onChanged: (value){
                                  setState(() {
                                    flag_permiso4=value;
                                  });
                                }),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children:[
                              Text('Permiso 5'),
                              SizedBox(width: 10,),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                value: flag_permiso5,
                                activeColor: Color.fromARGB(255, 57, 132, 59),
                                onChanged: (value){
                                  setState(() {
                                    flag_permiso5=value;
                                  });
                                }),
                              )
                            ],
                          ),
                        ],
                      )
                    );
                  },
                ),
                actions: [
                FilledButton.tonal(
                  child: Text('Cancelar'),
                  onPressed: (){
                    ctrl_nombre.text="";
                    flag_permiso1=false;
                    flag_permiso2=false;
                    flag_permiso3=false;
                    flag_permiso4=false;
                    flag_permiso5=false;
                    Navigator.of(context).pop();
                  }, 
                ),
                FilledButton(
                  child: Text('Agregar'),
                  onPressed: (){
                    setState(() {
                      //int newID=lista[lista.length-1].ID + 1;
                      //lista.add(Moderadores(ctrl_nombre.text, newID, flag_permiso1, flag_permiso2, flag_permiso3, flag_permiso4, flag_permiso5,'username'));
                      ctrl_nombre.text="";
                      flag_permiso1=false;
                      flag_permiso2=false;
                      flag_permiso3=false;
                      flag_permiso4=false;
                      flag_permiso5=false;
                      Navigator.of(context).pop();
                    });
                  }, 
                ),
              ],
              );
            },
          );
        },
      ),
      body: Center(
      child: Column(
          children: [
            SizedBox(height: 20,),
            Text('Lista de moderadores',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(10),
              height: 30,
              width: 200,
              child: TextField(
                controller: ctrl_query,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelStyle: TextStyle(fontSize: 5),
                  prefixIcon: const Icon(Icons.search,size: 20,),
                  suffixIcon: iconSearchBarCancel? IconButton(
                    icon: Icon(iconX,size: 15,),
                    onPressed: (){
                      setState(() {
                        ctrl_query.text="";
                        //lista=moderadoreslista;
                        iconSearchBarCancel=false;
                      });
                    }, 
                  ):null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 0.5,style: BorderStyle.solid),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    if(value==""){
                      //lista=moderadoreslista;
                      iconSearchBarCancel=false;
                    }else{
                      iconSearchBarCancel=true;
                      //lista=filter(value);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 5,),
            Container(
              height: MediaQuery.of(context).size.height*0.73,
              child: SingleChildScrollView(
                child: DataTable(
                  sortColumnIndex: 0,
                  sortAscending: sortAscending,
                  dataTextStyle: TextStyle(fontSize: 15,),
                  
                  columns: <DataColumn>[
                     DataColumn(
                      label: Text('Nombre'),
                      tooltip: 'Nombre',
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          sortAscending=!sortAscending;
                          onSortColumn(columnIndex, ascending);
                        });
                      },
                    ),
                    const DataColumn( // PERMISO 1
                      label: Expanded(child:Text('P1',textAlign: TextAlign.center,),),
                      tooltip: 'permiso 1',
                    ),
                    const DataColumn( // PERMISO 2
                      label: Expanded(child:Text('P2',textAlign: TextAlign.center,),),
                      tooltip: 'permiso 2',
                    ),
                    const DataColumn( // PERMISO 3
                      label: Expanded(child:Text('P3',textAlign: TextAlign.center,),),
                      tooltip: 'permiso 3',
                    ),
                    const DataColumn( // PERMISO 4
                      label: Expanded(child:Text('P4',textAlign: TextAlign.center,),),
                      tooltip: 'permiso 4',
                    ),
                    const DataColumn( // PERMISO 5
                      label: Expanded(child:Text('P5',textAlign: TextAlign.center,),),
                      tooltip: 'permiso 5',
                    ),
                    const DataColumn( // EDITAR
                      label: Text('editar/eliminar'),
                    ),
                  ], 
                  rows: lista.map<DataRow>((Moderators data){
                    return DataRow(
                      //key: LocalKey(data.ID),
                      cells: <DataCell>[
                        DataCell(
                          Text(data.userName)),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit,size: 17,),
                                onPressed: () {
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,size: 17,color: const Color.fromARGB(255, 138, 37, 30),),
                                onPressed: () {
                                  setState(() {
                                    //lista.removeWhere((element) => element.ID == data.ID);
                                  });
                                },
                              ),
                
                            ],
                          ),
                        ),
                      ],  
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 70,),
          ],
        ),
    ),
  );
  }
/*
  List<Moderadores> filter (String query){
    List<Moderadores> tmp = moderadoreslista;
    final cards = tmp.where((element) {
      String lowerName = element.nombre.toLowerCase();
      String lowerQuery = query.toLowerCase();
      return lowerName.contains(lowerQuery);
    }).toList();
    return cards;
  }
  */
}