import 'package:demo_casa_3/screens/data/transaccionesClass.dart';
import 'package:flutter/material.dart';

class HomeMB extends StatefulWidget {
  const HomeMB({super.key});

  @override
  State<HomeMB> createState() => _HomeMBMDState();
}

class _HomeMBMDState extends State<HomeMB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(height: 350, width: MediaQuery.of(context).size.width,color: Color.fromARGB(100, 125, 113, 82),
            child: Text('Ranking de la semana'),
          ),
          Container(height: 350, width: MediaQuery.of(context).size.width,color: Color.fromARGB(70, 125, 113, 82),
            child: Text('Ranking del mes'),
          ),
        ],
      ),
    );
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

void groupListByUser(){
  List<List<dynamic>> conteoSemanal = [];
  for(var element in listaprueba){
  }
}

  void rankingSemanal(){
    //agrupar rps
  }

  List<Transacciones> listaprueba = [
    Transacciones(moderator: "0000", clients_referred: 50, created_date: DateTime(2024, 4, 5), rp_user: "000", transaction_id: 1),
    Transacciones(moderator: "0000", clients_referred: 0, created_date: DateTime(2024, 4, 6), rp_user: "000", transaction_id: 2),
    Transacciones(moderator: "0000", clients_referred: 0, created_date: DateTime(2024, 4, 7), rp_user: "000", transaction_id: 3),
    Transacciones(moderator: "Mod1", clients_referred: 3, created_date: DateTime(2024, 4, 8), rp_user: "rp2", transaction_id: 4),
    Transacciones(moderator: "Mod4", clients_referred: 4, created_date: DateTime(2024, 4, 9), rp_user: "rp3", transaction_id: 5),
    Transacciones(moderator: "Mod2", clients_referred: 2, created_date: DateTime(2024, 4, 10), rp_user: "rp2", transaction_id: 6),
    Transacciones(moderator: "Mod7", clients_referred: 1, created_date: DateTime(2024, 4, 11), rp_user: "rp5", transaction_id: 7),
    Transacciones(moderator: "Mod3", clients_referred: 3, created_date: DateTime(2024, 4, 11), rp_user: "rp3", transaction_id: 8),
    Transacciones(moderator: "Mod1", clients_referred: 2, created_date: DateTime(2024, 4, 12), rp_user: "rp2", transaction_id: 9),
    Transacciones(moderator: "Mod4", clients_referred: 1, created_date: DateTime(2024, 4, 12), rp_user: "rp4", transaction_id: 10),
    Transacciones(moderator: "Mod3", clients_referred: 5, created_date: DateTime(2024, 4, 13), rp_user: "rp2", transaction_id: 11),
    Transacciones(moderator: "Mod5", clients_referred: 4, created_date: DateTime(2024, 4, 13), rp_user: "rp6", transaction_id: 12),
    Transacciones(moderator: "Mod6", clients_referred: 2, created_date: DateTime(2024, 4, 14), rp_user: "rp1", transaction_id: 13),
    Transacciones(moderator: "0000", clients_referred: 0, created_date: DateTime(2024, 4, 15), rp_user: "000", transaction_id: 14),
    Transacciones(moderator: "0000", clients_referred: 20, created_date: DateTime(2024, 4, 16), rp_user: "000", transaction_id: 15),
  ];

}