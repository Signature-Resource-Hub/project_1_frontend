// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
    String id;
    String userId;
    DateTime cancelledAt;
    int v;

    Order({
        required this.id,
        required this.userId,
        required this.cancelledAt,
        required this.v,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
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