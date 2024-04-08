// To parse this JSON data, do
//
//     final transacciones = transaccionesFromJson(jsonString);

import 'dart:convert';

List<Transacciones> transaccionesFromJson(String str) => List<Transacciones>.from(json.decode(str).map((x) => Transacciones.fromJson(x)));

String transaccionesToJson(List<Transacciones> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transacciones {
    final String moderator;
    final int clients_referred;
    final DateTime created_date;
    final String rp_user;
    final int transaction_id;

    Transacciones({
        required this.moderator,
        required this.clients_referred,
        required this.created_date,
        required this.rp_user,
        required this.transaction_id,
    });

    factory Transacciones.fromJson(Map<String, dynamic> json) => Transacciones(
        moderator: json["moderator"],
        clients_referred: json["clients_referred"],
        created_date: DateTime.parse(json["created_date"]),
        rp_user: json["rp_user"],
        transaction_id: json["transaction_id"],
    );

    Map<String, dynamic> toJson() => {
        "moderator": moderator,
        "clients_referred": clients_referred,
        "created_date": created_date.toIso8601String(),
        "rp_user": rp_user,
        "transaction_id": transaction_id,
    };
}
