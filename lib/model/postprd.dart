// To parse this JSON data, do
//
//     final bus = busFromJson(jsonString);

// import 'dart:convert';

// List<Bus> busFromJson(String str) => List<Bus>.from(json.decode(str).map((x) => Bus.fromJson(x)));

// String busToJson(List<Bus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Bus {
//     String id;
//     AcNonAc acNonAc;
//     BusFrom busFrom;
//     BusName busName;
//     BusTo busTo;
//     BusType busType;
//     int cost;
//     EndTime endTime;
//     int noOfSeats;
//     StartTime startTime;

//     Bus({
//         required this.id,
//         required this.acNonAc,
//         required this.busFrom,
//         required this.busName,
//         required this.busTo,
//         required this.busType,
//         required this.cost,
//         required this.endTime,
//         required this.noOfSeats,
//         required this.startTime,
//     });

//     factory Bus.fromJson(Map<String, dynamic> json) => Bus(
//         id: json["_id"],
//         acNonAc: acNonAcValues.map[json["acNonAc"]]!,
//         busFrom: busFromValues.map[json["busFrom"]]!,
//         busName: busNameValues.map[json["busName"]]!,
//         busTo: busToValues.map[json["busTo"]]!,
//         busType: busTypeValues.map[json["busType"]]!,
//         cost: json["cost"],
//         endTime: endTimeValues.map[json["endTime"]]!,
//         noOfSeats: json["noOfSeats"],
//         startTime: startTimeValues.map[json["startTime"]]!,
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "acNonAc": acNonAcValues.reverse[acNonAc],
//         "busFrom": busFromValues.reverse[busFrom],
//         "busName": busNameValues.reverse[busName],
//         "busTo": busToValues.reverse[busTo],
//         "busType": busTypeValues.reverse[busType],
//         "cost": cost,
//         "endTime": endTimeValues.reverse[endTime],
//         "noOfSeats": noOfSeats,
//         "startTime": startTimeValues.reverse[startTime],
//     };
// }

// enum AcNonAc {
//     AC
// }

// final acNonAcValues = EnumValues({
//     "AC": AcNonAc.AC
// });

// enum BusFrom {
//     BANGLORE
// }

// final busFromValues = EnumValues({
//     "Banglore": BusFrom.BANGLORE
// });

// enum BusName {
//     JABBAR_TRAVELS
// }

// final busNameValues = EnumValues({
//     "Jabbar Travels": BusName.JABBAR_TRAVELS
// });

// enum BusTo {
//     ERNAKULAM
// }

// final busToValues = EnumValues({
//     "Ernakulam": BusTo.ERNAKULAM
// });

// enum BusType {
//     SEMI_SLEEPER
// }

// final busTypeValues = EnumValues({
//     "Semi Sleeper": BusType.SEMI_SLEEPER
// });

// enum EndTime {
//     THE_0845
// }

// final endTimeValues = EnumValues({
//     "08:45": EndTime.THE_0845
// });

// enum StartTime {
//     THE_2235
// }

// final startTimeValues = EnumValues({
//     "22:35": StartTime.THE_2235
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
// To parse this JSON data, do
//
//     final bus = busFromJson(jsonString);

import 'dart:convert';

List<Bus> busFromJson(String str) => List<Bus>.from(json.decode(str).map((x) => Bus.fromJson(x)));

String busToJson(List<Bus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bus {
    String id;
    String acNonAc;
    String busFrom;
    String busName;
    String busTo;
    String busType;
    int cost;
    String endTime;
    int noOfSeats;
    String startTime;

    Bus({
        required this.id,
        required this.acNonAc,
        required this.busFrom,
        required this.busName,
        required this.busTo,
        required this.busType,
        required this.cost,
        required this.endTime,
        required this.noOfSeats,
        required this.startTime,
    });

    factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["_id"],
        acNonAc: json["acNonAc"],
        busFrom: json["busFrom"],
        busName: json["busName"],
        busTo: json["busTo"],
        busType: json["busType"],
        cost: json["cost"],
        endTime: json["endTime"],
        noOfSeats: json["noOfSeats"],
        startTime: json["startTime"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "acNonAc": acNonAc,
        "busFrom": busFrom,
        "busName": busName,
        "busTo": busTo,
        "busType": busType,
        "cost": cost,
        "endTime": endTime,
        "noOfSeats": noOfSeats,
        "startTime": startTime,
    };
}
