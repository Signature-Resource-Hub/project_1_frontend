// To parse this JSON data, do
//
//     final hotel = hotelFromJson(jsonString);

import 'dart:convert';

List<Hotel> hotelFromJson(String str) => List<Hotel>.from(json.decode(str).map((x) => Hotel.fromJson(x)));

String hotelToJson(List<Hotel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hotel {
    String id;
    String acNonAc;
    String availability;
    int cost;
    
    String hotelname;
    String location;
    int numberOfPersons;

    Hotel({
        required this.id,
        required this.acNonAc,
        required this.availability,
        required this.cost,
        required this.hotelname,
        required this.location,
        required this.numberOfPersons,
    });

    factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["_id"],
        acNonAc: json["acNonAc"],
        availability: json["availability"],
        cost: json["cost"],
        hotelname: json["hotelname"],
        location: json["location"],
        numberOfPersons: json["numberOfPersons"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "acNonAc": acNonAc,
        "availability": availability,
        "cost": cost,
        "hotelname": hotelname,
        "location": location,
        "numberOfPersons": numberOfPersons,
    };
}
