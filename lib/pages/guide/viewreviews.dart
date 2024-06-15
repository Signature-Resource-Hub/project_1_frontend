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
//   final guideReviewService = GuideReviewservice();
//   final updateService = updateservice();
//   final storage = const FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     fetchReviews();
//   }

//   List<Guidereview> reviews = [];

//   Future<void> fetchReviews() async {
    
//     String guideId = widget.guideId;
//     print('Fetching reviews for guideId: $guideId');
//     if (guideId.isNotEmpty) {
//       reviews = await guideReviewService.getReviewsByguide(guideId);
//       for (int i = 0; i < reviews.length; i++) {
//         final review = reviews[i];
//         final userDetails = await updateService.getUser(review.userid);
//         if (userDetails != null) {
//           final userdata = userDetails.data;
//           final name = userdata['username'];
//           review.userid = name; // Assuming `Guidereview` has a `username` field to store the reviewer's name
//         }
//       }
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('review'),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'review:',
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
//                       title: Text(
//                         'Rating: ${review.rating}',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       subtitle: Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Text(
//                           review.review,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       trailing: Text(
//                         review.userid ?? 'Anonymous',
//                         style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//                       ),
//                     ),
//                   );
//                 },
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
//                       title: Text(
//                         'Rating: ${review.rating}',
                        
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

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    String guideId = widget.guideId;
    if (guideId.isNotEmpty) {
      reviews = await guideReviewservice.getReviewsByguide(guideId);
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
                'Ratings  & Reviews:',
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
                        'userid:${review.userid}    Rating:${review.rating}',
                        
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
