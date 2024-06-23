import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/review.dart';
import 'package:project_1_frontend/services/reviewsservice.dart';

class ReviewPage extends StatefulWidget {
  final String hotelid;
  const ReviewPage({Key? key, required this.hotelid});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final Reviewservice reviewservice = Reviewservice();
  final TextEditingController reviewController = TextEditingController();
  final storage = const FlutterSecureStorage();
  double rating = 0;
  List<Reviews> reviews = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> addReview() async {
    Map<String, String> allValues = await storage.readAll();
    String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
    String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
    String hotelid = widget.hotelid;
    String reviewText = reviewController.text;

    if (userId.isNotEmpty && hotelid.isNotEmpty && rating != 0 && reviewText.isNotEmpty) {
      Reviews review = Reviews(
        id: '',
        userId: userId,
        hotelId: hotelid,
        rating: rating.toString(),
        review: reviewText,
        
        v: 0,
      );

      await reviewservice.addReview(userid: userId, hotelId: hotelid, review: reviewText, rating: rating.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Review added successfully'),
          backgroundColor: Colors.green,
        ),
      );
      rating = 0;
      reviewController.clear();
      fetchReviews();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> fetchReviews() async {
    setState(() {
      isLoading = true;
    });
    String hotelId = widget.hotelid;
    if (hotelId.isNotEmpty) {
      reviews = await reviewservice.getReviewsByHotel(hotelId);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Rate the hotel:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: reviewController,
                      decoration: InputDecoration(
                        labelText: 'Write your review',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: addReview,
                      icon: Icon(Icons.send),
                      label: Text('Submit Review'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
                        onPrimary: const Color.fromARGB(255, 7, 7, 7),
                      ),
                    ),
                    SizedBox(height: 30),
                    Divider(),
                    Text(
                      'User Reviews:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Row(
                              children: [
                                Text('Rating: ${review.rating}', style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                Icon(Icons.star, color: Colors.amber, size: 20),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(review.review),
                                SizedBox(height: 5),
                                
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}