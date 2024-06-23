// To parse this JSON data, do
//
//     final hotel = hotelFromJson(jsonString);

import 'dart:convert';

List<Hotel> hotelFromJson(String str) => List<Hotel>.from(json.decode(str).map((x) => Hotel.fromJson(x)));

String hotelToJson(List<Hotel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hotel {
    String userid;
    String id;
    String acNonAc;
    String availability;
    int cost;
    String hotelname;
    String location;
    String checkInTime;
    String checkOutTime;
    int numberOfPersons;
    int rating;


    Hotel({
      required this.userid,
        required this.id,
        required this.acNonAc,
        required this.availability,
        required this.cost,
        required this.hotelname,
        required this.location,
        required this.numberOfPersons,
        required this.checkInTime,
        required this.checkOutTime,
        required this.rating
    });

    factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
      userid: json["userid"],
        id: json["_id"],
        acNonAc: json["acNonAc"],
        availability: json["availability"],
        cost: json["cost"],
        hotelname: json["hotelname"],
        location: json["location"],
        numberOfPersons: json["numberOfPersons"],
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
        rating: json["rating"]
    );

    Map<String, dynamic> toJson() => {
      "userid": userid,
        "_id": id,
        "acNonAc": acNonAc,
        "availability": availability,
        "cost": cost,
        "hotelname": hotelname,
        "location": location,
        "numberOfPersons": numberOfPersons,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "rating": rating
    };
}