import 'package:demo_casa_3/screens/data/rpusersClass.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:flutter/material.dart';


class JugadoresMD extends StatefulWidget {
  const JugadoresMD({super.key});

  @override
  State<JugadoresMD> createState() => _JugadoresMDState();
}

class _JugadoresMDState extends State<JugadoresMD> {
  List<Jugadores> lista = [];
  TextEditingController ctrl_user = new TextEditingController();
  TextEditingController ctrl_query = new TextEditingController();
  bool iconSearchBarCancel=false;
  bool sortAscendingptos = true;

  onSortColumn(int colIndex, bool ascending){
    if(ascending){
      lista.sort((a,b)=>a.totalClientsReferred.compareTo(b.totalClientsReferred));
    }else{
      lista.sort((a,b)=>b.totalClientsReferred.compareTo(a.totalClientsReferred));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Lista: '+lista.length.toString());
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Lista de Jugadores',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
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
                        lista=[];
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
                      lista=[];
                      iconSearchBarCancel=false;
                    }else{
                      iconSearchBarCancel=true;
                      lista=filter(value);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.height*0.9,
              child: SingleChildScrollView(
                child: DataTable(
                  sortColumnIndex: 1,
                  sortAscending: sortAscendingptos,
                  dataTextStyle: TextStyle(fontSize: 15,),
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Text('Jugadores'),
                      tooltip: 'Jugadores',
                    ),
                    DataColumn(
                      label: Text('Puntos'),
                      tooltip: 'Puntos',
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          sortAscendingptos=!sortAscendingptos;
                          onSortColumn(columnIndex, ascending);
                        });
                      },
                    ),
                    const DataColumn(
                      label: Text('Boletos'),
                      tooltip: 'Boletos',
                    ),
                    DataColumn(
                      label: Text('Bebidas\nCanjeadas',textAlign: TextAlign.center,),
                      tooltip: 'Bebidas Canjeadas',
                    ),
                    DataColumn(
                      label: Text('-'),
                      tooltip: '-',
                    ),
                  ], 
                  rows: lista.map<DataRow>((Jugadores data){
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(data.userName),
                        ),
                        DataCell(
                          Text(data.totalClientsReferred.toString()),
                        ),
                        DataCell(
                          Text(data.totalClientsReferred.toString()),
                        ),
                        DataCell(
                          Text(data.totalClientsReferred.toString()),
                        ),
                        DataCell(
                          Text(data.totalClientsReferred.toString()),
                        ),
                      ], 
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Jugadores> filter (String query){
    final cards = lista.where((element) {
      String lowerName = element.userName.toLowerCase();
      String lowerQuery = query.toLowerCase();
      return lowerName.contains(lowerQuery);
    }).toList();
    return cards;
  }
}