import 'dart:convert';

List<Guide> guideFromJson(String str) => List<Guide>.from(json.decode(str).map((x) => Guide.fromJson(x)));

String guideToJson(List<Guide> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guide {
    String id;
    Userid userid;
    String location;
    int star;
    String contents;
    DateTime timestamp;
    int v;

    Guide({
        required this.id,
        required this.userid,
        required this.location,
        required this.star,
        required this.contents,
        required this.timestamp,
        required this.v,
    });

    factory Guide.fromJson(Map<String, dynamic> json) => Guide(
        id: json["_id"],
        userid: Userid.fromJson(json["userid"]),
        location: json["location"],
        star: json["star"],
        contents: json["contents"],
        timestamp: DateTime.parse(json["timestamp"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid.toJson(),
        "location": location,
        "star": star,
        "contents": contents,
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
