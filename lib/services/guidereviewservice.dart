// import 'package:dio/dio.dart';
// import 'package:project_1_frontend/model/guidereview.dart';
// import 'package:project_1_frontend/model/review.dart';
// import 'package:project_1_frontend/services/authservice.dart';
// import 'package:project_1_frontend/services/config.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// class GuideReviewservice {
//   final Dio dio = Dio();
//    final storage = const FlutterSecureStorage();
//   Config configObj = Config();

//   Future<Response> addReview({
//     required String userid,
//     required String guideId,
//     required String rating,
//     required String review, 
//   }) async {
   
//      try {
//       final response = await dio.post(
//         "${configObj.url}addguideReview",
//         data: {
//           'userid': userid,
//           'guideId': guideId,
//           'rating': rating,
//           'review': review,
//         },
//       );
//       return response;
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to add review: $e');
//     }
//   }
// // Future<List<Review>> getReviewsByguide(String guideId) async {
// //     try {
// //       final response = await dio.post(
// //         "${configObj.url}getReviewsByguide",
// //         data: {'guideId': guideId},
// //       );

// //       if (response.statusCode == 200) {
// //         List<dynamic> data = response.data['reviews'];
// //         return data.map((json) => Review.fromJson(json)).toList();
// //       } else if (response.statusCode == 201) {
// //         print(response.data['message']);
// //         return [];
// //       } else {
// //         print('Failed to fetch reviews: ${response.data['message']}');
// //         return [];
// //       }
// //     } catch (e) {
// //       print('Error fetching reviews: $e');
// //       return [];
// //     }
// //   }

// Future<List<Guidereview>> getReviewsByguide(String guideId) async {
//   try {
//     final response = await dio.post(
//       "${configObj.url}getReviewsByguide",
//       data: {'guideId': guideId},
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> data = response.data['reviews'];
//       return data.map((json) => Guidereview.fromJson(json)).toList();
//     } else if (response.statusCode == 201) {
//       print(response.data['message']);
//       return [];
//     } else {
//       print('Failed to fetch reviews: ${response.data['message']}');
//       return [];
//     }
//   } catch (e) {
//     print('Error fetching reviews: $e');
//     return [];
//   }
// }

// }


import 'package:dio/dio.dart';
import 'package:project_1_frontend/model/guidereview.dart';
import 'package:project_1_frontend/model/review.dart';
import 'package:project_1_frontend/services/authservice.dart';
import 'package:project_1_frontend/services/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GuideReviewservice {
  final Dio dio = Dio();
   final storage = const FlutterSecureStorage();
  Config configObj = Config();

  Future<Response> addReview({
    required String userid,
    required String guideId,
    required String rating,
    required String review, 
  }) async {
   
     try {
      final response = await dio.post(
        "${configObj.url}addguideReview",
        data: {
          'userid': userid,
          'guideId': guideId,
          'rating': rating,
          'review': review,
        },
      );
      return response;
    } catch (e) {
      print(e);
      throw Exception('Failed to add review: $e');
    }
  }
// Future<List<Review>> getReviewsByguide(String guideId) async {
//     try {
//       final response = await dio.post(
//         "${configObj.url}getReviewsByguide",
//         data: {'guideId': guideId},
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data['reviews'];
//         return data.map((json) => Review.fromJson(json)).toList();
//       } else if (response.statusCode == 201) {
//         print(response.data['message']);
//         return [];
//       } else {
//         print('Failed to fetch reviews: ${response.data['message']}');
//         return [];
//       }
//     } catch (e) {
//       print('Error fetching reviews: $e');
//       return [];
//     }
//   }

Future<List<Guidereview>> getReviewsByguide(String guideId) async {
  try {
    final response = await dio.post(
      "${configObj.url}getReviewsByguide",
      data: {'guideId': guideId},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['reviews'];
      return data.map((json) => Guidereview.fromJson(json)).toList();
    } else if (response.statusCode == 201) {
      print(response.data['message']);
      return [];
    } else {
      print('Failed to fetch reviews: ${response.data['message']}');
      return [];
    }
  } catch (e) {
    print('Error fetching reviews: $e');
    return [];
  }
}

}
