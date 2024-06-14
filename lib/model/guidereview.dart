// To parse this JSON data, do
//
//     final guidereview = guidereviewFromJson(jsonString);

import 'dart:convert';

List<Guidereview> guidereviewFromJson(String str) => List<Guidereview>.from(json.decode(str).map((x) => Guidereview.fromJson(x)));

String guidereviewToJson(List<Guidereview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guidereview {
    String id;
    String userid;
    String guideId;
    String rating;
    String review;
    int v;

    Guidereview({
        required this.id,
        required this.userid,
        required this.guideId,
        required this.rating,
        required this.review,
        required this.v,
    });

    factory Guidereview.fromJson(Map<String, dynamic> json) => Guidereview(
        id: json["_id"],
        userid: json["userid"],
        guideId: json["guideId"],
        rating: json["rating"],
        review: json["review"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "guideId": guideId,
        "rating": rating,
        "review": review,
        "__v": v,
    };
}


