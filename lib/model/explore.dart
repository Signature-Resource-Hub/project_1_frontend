import 'dart:convert';

List<Bus> busFromJson(String str) => List<Bus>.from(json.decode(str).map((x) => Bus.fromJson(x)));

String busToJson(List<Bus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bus {
    String userid;
    String busName;
    String busFrom;
    String busTo;
    String startTime;
    String endTime;
    String acNonAc;
    int cost;
    String description;
    int noOfSeats;
    String busType;
    List<DateTime> availableDate;
    List<PPoint> pickupPoints;
    List<PPoint> dropPoints;
    String id;
    int v;

    Bus({
        required this.userid,
        required this.busName,
        required this.busFrom,
        required this.busTo,
        required this.startTime,
        required this.endTime,
        required this.acNonAc,
        required this.cost,
        required this.description,
        required this.noOfSeats,
        required this.busType,
        required this.availableDate,
        required this.pickupPoints,
        required this.dropPoints,
        required this.id,
        required this.v,
    });

    factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        userid: json["userid"],
        busName: json["busName"],
        busFrom: json["busFrom"],
        busTo: json["busTo"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        acNonAc: json["acNonAc"],
        cost: json["cost"],
        description: json["description"],
        noOfSeats: json["noOfSeats"],
        busType: json["busType"],
        availableDate: List<DateTime>.from(json["availableDate"].map((x) => DateTime.parse(x))),
        pickupPoints: List<PPoint>.from(json["pickupPoints"].map((x) => PPoint.fromJson(x))),
        dropPoints: List<PPoint>.from(json["dropPoints"].map((x) => PPoint.fromJson(x))),
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "busName": busName,
        "busFrom": busFrom,
        "busTo": busTo,
        "startTime": startTime,
        "endTime": endTime,
        "acNonAc": acNonAc,
        "cost": cost,
        "description": description,
        "noOfSeats": noOfSeats,
        "busType": busType,
        "availableDate": List<dynamic>.from(availableDate.map((x) => x.toIso8601String())),
        "pickupPoints": List<dynamic>.from(pickupPoints.map((x) => x.toJson())),
        "dropPoints": List<dynamic>.from(dropPoints.map((x) => x.toJson())),
        "_id": id,
        "__v": v,
    };
}

class PPoint {
    String name;
    String time;

    PPoint({
        required this.name,
        required this.time,
    });

    factory PPoint.fromJson(Map<String, dynamic> json) => PPoint(
        name: json["name"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
    };
}
