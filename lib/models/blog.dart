// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

List<Blog> blogFromJson(String str) => List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));

String blogToJson(List<Blog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Blog {
    String id;
    Userid userid;
    String location;
    String content;
    DateTime timestamp;
    int v;

    Blog({
        required this.id,
        required this.userid,
        required this.content,
        required this.location,
        required this.timestamp,
        required this.v,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["_id"],
        userid: Userid.fromJson(json["userid"]),
        content: json["content"],
        location: json["location"],
        timestamp: DateTime.parse(json["timestamp"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid.toJson(),
        "content": content,
        "location": location,
        "timestamp": timestamp.toIso8601String(),
        "__v": v,
    };
}

class Userid {
    String id;
    String username;
    String email;
    String password;
    int phone;
    String userType;

    Userid({
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.phone,
        required this.userType,
    });

    factory Userid.fromJson(Map<String, dynamic> json) => Userid(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        userType: json["user_type"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "user_type": userType,
    };
}
