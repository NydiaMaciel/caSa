// To parse this JSON data, do
//
//     final moderators = moderatorsFromJson(jsonString);

import 'dart:convert';

List<Moderators> moderatorsFromJson(String str) => List<Moderators>.from(json.decode(str).map((x) => Moderators.fromJson(x)));

String moderatorsToJson(List<Moderators> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Moderators {
    int id;
    String userName;
    String email;

    Moderators({
        required this.id,
        required this.userName,
        required this.email,
    });

    factory Moderators.fromJson(Map<String, dynamic> json) => Moderators(
        id: json["id"],
        userName: json["user_name"],
        email: json["email"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
    };

    //String getBodyString (){return'';}
}
