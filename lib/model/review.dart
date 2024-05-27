import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    String id;
    String userid;
    String busId;
    String rating;
    String review;
    int v;

    Review({
        required this.id,
        required this.userid,
        required this.busId,
        required this.rating,
        required this.review,
        required this.v,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        userid: json["userid"],
        busId: json["busId"],
        rating: json["rating"],
        review: json["review"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "busId": busId,
        "rating": rating,
        "review": review,
        "__v": v,
    };
}
