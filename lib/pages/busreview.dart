// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:project_1_frontend/model/review.dart';
// import 'package:project_1_frontend/services/reviewservice.dart';

// class ReviewPage extends StatefulWidget {
//   final String busId;
//   const ReviewPage({Key? key,required this.busId});

//   @override
//   State<ReviewPage> createState() => _ReviewPageState();
// }

// class _ReviewPageState extends State<ReviewPage> {
//   final  Reviewservice reviewservice = Reviewservice();
//   final TextEditingController reviewController = TextEditingController();
// final storage=const FlutterSecureStorage();
//  void initState(){
//   super.initState();
//   fetchReviews();
//    }
//   double rating = 0;
//   List<Review> reviews = [];

//   // Add Review Function
//   Future<void> addReview() async {Map<String,String> allvalues=await storage.readAll();
//                    String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//                    print(normalizedSource);
//                    String userId=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
                   
    
    
//     String busid = widget.busId;
//     String reviewText = reviewController.text;

//     if (userId.isNotEmpty && busid.isNotEmpty && rating != 0 && reviewText.isNotEmpty) {
//       Review review = Review(
//         id: '',
//         userid: userId,
//         busId: busid,
//         rating: rating.toString(),
//         review: reviewText,
//         v: 0,
//       );

//       await reviewservice.addReview(userid: userId,busId: busid,review: reviewText,rating: rating.toString());
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review added successfully')));
//       rating = 0;
//       reviewController.clear();
//       fetchReviews();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
//     }
//   }

//   // Fetch Reviews Function
//   Future<void> fetchReviews() async {
//     String busId = widget.busId;
//     if (busId.isNotEmpty) {
//       reviews = await reviewservice.getReviewsByBus(busId);
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Reviews')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               Text(
//                 'Rating:',
//                 style: TextStyle(fontSize: 16),
//               ),
//               RatingBar.builder(
//                 initialRating: rating,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemBuilder: (context, _) => Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   setState(() {
//                     this.rating = rating;
//                   });
//                 },
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: reviewController,
//                 decoration: InputDecoration(labelText: 'Review'),
//                 maxLines: 4,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: addReview,
//                 child: Text('Add Review'),
//               ),
//               SizedBox(height: 20),
//               SizedBox(height: 20),
//               Text(
//                 'Reviews:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: reviews.length,
//                 itemBuilder: (context, index) {
//                   final review = reviews[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text('Rating: ${review.rating}'),
//                       subtitle: Text(review.review),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/model/review.dart';
import 'package:project_1_frontend/models/guidemodel.dart';
import 'package:project_1_frontend/services/reviewservice.dart';
import 'package:project_1_frontend/services/updateservice.dart';

class ReviewPage extends StatefulWidget {
  final String busId;

  const ReviewPage({Key? key, required this.busId}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final Reviewservice reviewservice = Reviewservice();
  final updateservice userservice=updateservice();
  final TextEditingController reviewController = TextEditingController();
  final storage = const FlutterSecureStorage();

  void initState() {
    super.initState();
    fetchReviews();
  }

  double rating = 0;
  List<Review> reviews = [];

  // Add Review Function
  Future<void> addReview() async {
    Map<String, String> allValues = await storage.readAll();
    String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
    print(normalizedSource);
    String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

    String busid = widget.busId;
    String reviewText = reviewController.text;

    if (userId.isNotEmpty && busid.isNotEmpty && rating != 0 && reviewText.isNotEmpty) {
      Review review = Review(
        id: '',
        userid: userId,
        busId: busid,
        rating: rating.toString(),
        review: reviewText,
        
        v: 0,
      );

      await reviewservice.addReview(userid: userId, busId: busid, review: reviewText, rating: rating.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review added successfully')));
      rating = 0;
      reviewController.clear();
      fetchReviews();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
    }
  }
  String usrid ='';
  // Fetch Reviews Function
  Future<void> fetchReviews() async {
    String busId = widget.busId;
    if (busId.isNotEmpty) {
      reviews = await reviewservice.getReviewsByBus(busId);
      for (int i = 0; i < reviews.length; i++) {
      final review = reviews[i];
      final userDetails = await userservice.getUser(review.userid);
      if (userDetails != null) {
        // Assuming user details contain a name field
        final userdata =userDetails.data;
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
