// To parse this JSON data, do
//
//     final jugadores = jugadoresFromJson(jsonString);

import 'dart:convert';

List<Jugadores> jugadoresFromJson(String str) => List<Jugadores>.from(json.decode(str).map((x) => Jugadores.fromJson(x)));

String jugadoresToJson(List<Jugadores> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jugadores {
    final int id;
    final String userName;
    final String email;
    final int totalClientsReferred;
    final String phoneNumber;
    final String qrCode;

    Jugadores({
        required this.id,
        required this.userName,
        required this.email,
        required this.totalClientsReferred,
        required this.phoneNumber,
        required this.qrCode,
    });

    factory Jugadores.fromJson(Map<String, dynamic> json) => Jugadores(
        id: json["id"],
        userName: json["user_name"],
        email: json["email"],
        totalClientsReferred: json["total_clients_referred"],
        phoneNumber: json["phone_number"],
        qrCode: json["qr_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
        "total_clients_referred": totalClientsReferred,
        "phone_number": phoneNumber,
        "qr_code": qrCode,
    };
}
