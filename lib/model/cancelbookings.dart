// To parse this JSON data, do
//
//     final cancelledbookings = cancelledbookingsFromJson(jsonString);

import 'dart:convert';

List<Cancelledbookings> cancelledbookingsFromJson(String str) => List<Cancelledbookings>.from(json.decode(str).map((x) => Cancelledbookings.fromJson(x)));

String cancelledbookingsToJson(List<Cancelledbookings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cancelledbookings {
    String id;
    String userId;
    DateTime cancelledAt;
    int v;

    Cancelledbookings({
        required this.id,
        required this.userId,
        required this.cancelledAt,
        required this.v,
    });

    factory Cancelledbookings.fromJson(Map<String, dynamic> json) => Cancelledbookings(
        id: json["_id"],
        userId: json["userId"],
        cancelledAt: DateTime.parse(json["cancelledAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "cancelledAt": cancelledAt.toIso8601String(),
        "__v": v,
    };
}
