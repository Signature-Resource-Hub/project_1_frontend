import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/model/guidereview.dart';
import 'package:project_1_frontend/model/review.dart';
import 'package:project_1_frontend/models/guidemodel.dart';
import 'package:project_1_frontend/services/guidereviewservice.dart';
import 'package:project_1_frontend/services/reviewservice.dart';
import 'package:project_1_frontend/services/updateservice.dart';

class userguidereviews extends StatefulWidget {
  final String guideId;

  const userguidereviews({Key? key, required this.guideId}) : super(key: key);

  @override
  State<userguidereviews> createState() => _userguidereviewsState();
}

class _userguidereviewsState extends State<userguidereviews> {
  final guideReviewservice  = GuideReviewservice();
  final updateservice userservice=updateservice();
  final TextEditingController reviewController = TextEditingController();
  final storage = const FlutterSecureStorage();

    void initState() {
    super.initState();
    fetchReviews();
  }

  double rating = 0;
  List<Guidereview> reviews = [];

  Future<void> addReview() async {
    Map<String, String> allValues = await storage.readAll();
    String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
    String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

    String guideId = widget.guideId;
    String reviewText = reviewController.text;

    if (userId.isNotEmpty && guideId.isNotEmpty && rating != 0 && reviewText.isNotEmpty) {
      Guidereview review = Guidereview(
        id: '',
        userid: userId,
        guideId: guideId,
        rating: rating.toString(),
        review: reviewText,
        v: 0,
      );

      await guideReviewservice.addReview(userid: userId, guideId: guideId, review: reviewText, rating: rating.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review added successfully')));
      rating = 0;
      reviewController.clear();
      fetchReviews();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
    }
  }

  Future<void> fetchReviews() async {
    String guideId = widget.guideId;
    if (guideId.isNotEmpty) {
      reviews = await guideReviewservice.getReviewsByguide(guideId);
      for (int i = 0; i < reviews.length; i++) {
        final review = reviews[i];
        final userDetails = await userservice.getUser(review.userid);
        if (userDetails != null) {
          final userdata = userDetails.data;
          final name = userdata['username'];
        }
      }

      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate this bus',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
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
              Center(
                child: ElevatedButton(
                  onPressed: addReview,
                  child: Text('Submit Review'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'Reviews:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        'Rating: ${review.rating}',
                        
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),

                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(review.review, style: TextStyle(fontSize: 16)),
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