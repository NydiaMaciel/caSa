import 'dart:convert';
import 'dart:io';

class Rifa {
  String titulo;
  String descripcion;
  int puntos;
  DateTime fecha;

  Rifa({required this.titulo, required this.descripcion, required this.puntos, required this.fecha});

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'puntos': puntos,
      'fecha': fecha.toIso8601String(),
    };
  }
}

void generarArchivo(List<Rifa> rifas) {
  final jsonData = rifas.map((rifa) => rifa.toJson()).toList();
  final jsonString = jsonEncode(jsonData);

  final file = File('eventsRif.txt');
  file.writeAsStringSync(jsonString);

  print('Archivo generado exitosamente.');
}
///////////////////////
void main() {
  List<Rifa> rifas = [
    Rifa(
      titulo: 'Rifa 1',
      descripcion: 'Descripción de la Rifa 1',
      puntos: 100,
      fecha: DateTime.now(),
    ),
    Rifa(
      titulo: 'Rifa 2',
      descripcion: 'Descripción de la Rifa 2',
      puntos: 200,
      fecha: DateTime.now(),
    ),
  ];

  generarArchivo(rifas);
}
