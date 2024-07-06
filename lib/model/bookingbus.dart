// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

// import 'dart:convert';

// List<Booking> bookingFromJson(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

// String bookingToJson(List<Booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Booking {
//     String userId;
//     String busId;
//     String from;
//     String to;
//     String startTime;
//     String endTime;
//     int numberOfSeats;
//     int totalCost;
//     String pickupPoint;
//     String dropPoint;
//     List<Traveler> travelers;
//     String id;
//     DateTime createdAt;
//     int v;

//     Booking({
//         required this.userId,
//         required this.busId,
//         required this.from,
//         required this.to,
//         required this.startTime,
//         required this.endTime,
//         required this.numberOfSeats,
//         required this.totalCost,
//         required this.pickupPoint,
//         required this.dropPoint,
//         required this.travelers,
//         required this.id,
//         required this.createdAt,
//         required this.v,
//     });

//     factory Booking.fromJson(Map<String, dynamic> json) => Booking(
//         userId: json["userId"],
//         busId: json["busId"],
//         from: json["from"],
//         to: json["to"],
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         numberOfSeats: json["numberOfSeats"],
//         totalCost: json["totalCost"],
//         pickupPoint: json["pickupPoint"],
//         dropPoint: json["dropPoint"],
//         travelers: List<Traveler>.from(json["travelers"].map((x) => Traveler.fromJson(x))),
//         id: json["_id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "busId": busId,
//         "from": from,
//         "to": to,
//         "startTime": startTime,
//         "endTime": endTime,
//         "numberOfSeats": numberOfSeats,
//         "totalCost": totalCost,
//         "pickupPoint": pickupPoint,
//         "dropPoint": dropPoint,
//         "travelers": List<dynamic>.from(travelers.map((x) => x.toJson())),
//         "_id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class Traveler {
//     String fullName;
//     int age;
//     String gender;
//     String id;

//     Traveler({
//         required this.fullName,
//         required this.age,
//         required this.gender,
//         required this.id,
//     });

//     factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
//         fullName: json["fullName"],
//         age: json["age"],
//         gender: json["gender"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fullName": fullName,
//         "age": age,
//         "gender": gender,
//         "_id": id,
//     };
// }
class Busbookings {
  final String id;
  final String userId;
  final String busFrom;
  final String busTo;
  final DateTime createdAt;
  final String startTime;
  final String endTime;
  final String status;
  final Map<String, dynamic>? selectedPickupPoint; // Ensure this matches your usage

  Busbookings({
    required this.id,
    required this.userId,
    required this.busFrom,
    required this.busTo,
    required this.createdAt,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.selectedPickupPoint, // Optional: ensure it's nullable if not always present
  });

  factory Busbookings.fromJson(Map<String, dynamic> json) {
    return Busbookings(
      id: json['id'],
      userId: json['userId'],
      busFrom: json['from'],
      busTo: json['to'],
      createdAt: DateTime.parse(json['createdAt']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      selectedPickupPoint: json['pickupPoint'], // Ensure this matches your JSON key
    );
  }
}
