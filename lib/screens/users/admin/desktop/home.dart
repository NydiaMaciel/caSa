import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeMDState();
}

class _HomeMDState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(height: 200, width: MediaQuery.of(context).size.width,color: Colors.green,
              child: Text('Proxima Rifa'),
            ),*/
            Row(
              children: [
                Container(height: 400, width: (MediaQuery.of(context).size.width-250)/2,color: Color.fromARGB(100, 125, 113, 82),
                  child: Text('Ranking de la semana'),
                ),
              Container(height: 400, width: (MediaQuery.of(context).size.width-250)/2,color: Color.fromARGB(70, 125, 113, 82),
                child: Text('Ranking del mes'),
              ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

void rankWeek(){
  var transWeekList = [];
  //lista de rps de la semana
  //ordenar rps por invitados
}

void rankMonth(){
  var transMonthkList = [];
  //lista de rps de la semana
  //ordenar rps por invitados
}

void calcularRangoSemana(DateTime fecha) {
  int diaSemana = fecha.weekday;

  DateTime lunes = fecha.subtract(Duration(days: diaSemana - 1));
  DateTime domingo = fecha.add(Duration(days: 7 - diaSemana));
  // Formatear las fechas en formato legible
  String fechaInicioSemana = '${lunes.day}/${lunes.month}/${lunes.year}';
  String fechaFinSemana = '${domingo.day}/${domingo.month}/${domingo.year}';
}

bool estaEnRango(DateTime day_x, DateTime day_a, DateTime day_b) {
  return day_x.isAfter(day_a.subtract(Duration(days: 1))) &&
      day_x.isBefore(day_b.add(Duration(days: 1)));
}