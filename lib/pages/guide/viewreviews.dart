// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:project_1_frontend/model/guidereview.dart';
// import 'package:project_1_frontend/services/guidereviewservice.dart';
// import 'package:project_1_frontend/services/updateservice.dart';

// class viewreviews extends StatefulWidget {
//   final String guideId;

//   const viewreviews({Key? key, required this.guideId}) : super(key: key);

//   @override
//   State<viewreviews> createState() => _viewreviewsState();
// }

// class _viewreviewsState extends State<viewreviews> {
//   final guideReviewservice = GuideReviewservice();
//   final updateservice userservice = updateservice();
//   List<Guidereview> reviews = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchReviews();
//   }

//   Future<void> fetchReviews() async {
//     String guideId = widget.guideId;
//     if (guideId.isNotEmpty) {
//       reviews = await guideReviewservice.getReviewsByguide(guideId);
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reviews'),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Ratings  & Reviews:',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: reviews.length,
//                 itemBuilder: (context, index) {
//                   final review = reviews[index];
//                   return Card(
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
                    
//                     child: ListTile(
//                       // title: Text(
//                       //   'userid:${review.userid}    Rating:${review.rating}',
                        
//                       //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       // ),
//                       title: Text(
//                         'Rating:${review.rating}',
                        
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       subtitle: Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Text(review.review, style: TextStyle(fontSize: 16)),
//                       ),
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
import 'package:project_1_frontend/model/guidereview.dart';
import 'package:project_1_frontend/services/guidereviewservice.dart';
import 'package:project_1_frontend/services/updateservice.dart';

class viewreviews extends StatefulWidget {
  final String guideId;

  const viewreviews({Key? key, required this.guideId}) : super(key: key);

  @override
  State<viewreviews> createState() => _viewreviewsState();
}

class _viewreviewsState extends State<viewreviews> {
  final guideReviewservice = GuideReviewservice();
  final updateservice userservice = updateservice();
  List<Guidereview> reviews = [];
  double averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    String guideId = widget.guideId;
    if (guideId.isNotEmpty) {
      reviews = await guideReviewservice.getReviewsByguide(guideId);
      calculateAverageRating();
      setState(() {});
    }
  }

  void calculateAverageRating() {
    if (reviews.isNotEmpty) {
      double totalRating = reviews.fold(0.0, (sum, review) => sum + double.parse(review.rating));
      averageRating = totalRating / reviews.length;
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
                'Ratings & Reviews:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Overall Ratings: ${averageRating.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 18),
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
