import 'package:flutter/material.dart';


const List<String> typeListGraph = <String>['Número de Invitados','Frecuencia de Invitados','Gasto de Invitados',];
const List<String> timeListGraph = <String>['por Día','por Semana','por Mes',];

class Analitics extends StatefulWidget{
  @override
  State<Analitics> createState() => _Analitics();
}

class _Analitics extends State<Analitics>{
  String typeListSelected = typeListGraph[0];
  String timeListSelected = timeListGraph[0];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 5,),
                DropdownButton(
                  value: typeListSelected,
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  icon: Icon(Icons.arrow_drop_down),//arrow_drop_down_rounded
                  items: typeListGraph.map((String typeListGraph){
                    return DropdownMenuItem(
                      value: typeListGraph,
                      child: Text(typeListGraph,),
                    );
                  }).toList(),
                  onChanged: (String? newvalue) {
                    //
                    setState(() {
                      typeListSelected = newvalue!;
                    });
                  },
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  value: timeListSelected,
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  icon: Icon(Icons.arrow_drop_down),//arrow_drop_down_rounded
                  items: timeListGraph.map((String timeListGraph){
                    return DropdownMenuItem(
                      value: timeListGraph,
                      child: Text(timeListGraph),
                    );
                  }).toList(),
                  onChanged: (String? newvalue) {
                    //
                    setState(() {
                      timeListSelected = newvalue!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text(typeListSelected+' - '+timeListSelected,
            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
          ),
        ]),
      ),
    );
  }
}