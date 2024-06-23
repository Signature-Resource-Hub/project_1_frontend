import 'dart:convert';

// Function to parse JSON data
BlogView blogViewFromJson(String str) => BlogView.fromJson(json.decode(str));

// Function to convert object to JSON string
String blogViewToJson(BlogView data) => json.encode(data.toJson());

// Model for the response from the viewAllBlogs API
class BlogView {
  String status;
  List<Datum> data;

  BlogView({
    required this.status,
    required this.data,
  });

  factory BlogView.fromJson(Map<String, dynamic> json) => BlogView(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

// Model for individual blog data
class Datum {
  String id;
  Userid userid;
  String content;
  DateTime timestamp;
  int v;

  Datum({
    required this.id,
    required this.userid,
    required this.content,
    required this.timestamp,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userid: Userid.fromJson(json["userid"]),
        content: json["content"],
        timestamp: DateTime.parse(json["timestamp"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid.toJson(),
        "content": content,
        "timestamp": timestamp.toIso8601String(),
        "__v": v,
      };
}

// Model for the user data associated with each blog
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