import 'dart:convert';

List<Reviews> reviewsFromJson(String str) => List<Reviews>.from(json.decode(str).map((x) => Reviews.fromJson(x)));

String reviewsToJson(List<Reviews> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reviews {
    String id;
    String userId;
    String hotelId;
    String rating;
    String review;
    
    int v;

    Reviews({
        required this.id,
        required this.userId,
        required this.hotelId,
        required this.rating,
        required this.review,
        
        required this.v,
    });

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        id: json["_id"],
        userId: json["user_id"],
        hotelId: json["hotel_id"],
        rating: json["rating"],
        review: json["review"],
        
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "hotel_id": hotelId,
        "rating": rating,
        "review": review,
        
        "__v": v,
    };
}
