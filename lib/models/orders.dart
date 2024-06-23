// // To parse this JSON data, do
// //
// //     final display = displayFromJson(jsonString);

// import 'dart:convert';

// List<Display> displayFromJson(String str) => List<Display>.from(json.decode(str).map((x) => Display.fromJson(x)));

// String displayToJson(List<Display> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Display {
//     String id;
//     String userid;
//     String hotelId;
//     String bookFor;
//     String price;
//     DateTime bookingDate;
//     int v;

//     Display({
//         required this.id,
//         required this.userid,
//         required this.hotelId,
//         required this.bookFor,
//         required this.price,
//         required this.bookingDate,
//         required this.v,
//     });

//     factory Display.fromJson(Map<String, dynamic> json) => Display(
//         id: json["_id"],
//         userid: json["userid"],
//         hotelId: json["hotel_id"],
//         bookFor: json["book_for"],
//         price: json["price"],
//         bookingDate: DateTime.parse(json["booking_date"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userid": userid,
//         "hotel_id": hotelId,
//         "book_for": bookFor,
//         "price": price,
//         "booking_date": bookingDate.toIso8601String(),
//         "__v": v,
//     };
// }


// To parse this JSON data, do
//
//     final display = displayFromJson(jsonString);

import 'dart:convert';

List<Display> displayFromJson(String str) => List<Display>.from(json.decode(str).map((x) => Display.fromJson(x)));

String displayToJson(List<Display> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Display {
    String id;
    String userid;
    String hotelId;
    String bookFor;
    String price;
    String username;
    String useremail;
    String userphone;
    DateTime bookingDate;
    
    
   
    int v;

    Display({
        required this.id,
        required this.userid,
        required this.hotelId,
        required this.bookFor,
        required this.price,
        required this.username,
        required this.useremail,
        required this.userphone,
        required this.bookingDate,
        
       
        required this.v,
    });

    factory Display.fromJson(Map<String, dynamic> json) => Display(
        id: json["_id"],
        userid: json["userid"],
        hotelId: json["hotel_id"],
        bookFor: json["book_for"],
        price: json["price"],
        username: json["username"],
        useremail: json["useremail"],
        userphone: json["userphone"],
        bookingDate: DateTime.parse(json["booking_date"]),
       
       
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "hotel_id": hotelId,
        "book_for": bookFor,
        "price": price,
        "username": username,
        "useremail": useremail,
        "userphone": userphone,
        "booking_date": bookingDate.toIso8601String(),
        
       
        "__v": v,
    };
}