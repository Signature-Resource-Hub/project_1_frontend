import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:project_1_frontend/model/postprd.dart';
import 'package:project_1_frontend/models/review.dart';
//import 'package:project_1_frontend/model/review.dart';
import 'package:project_1_frontend/services/authservice.dart';
import 'package:project_1_frontend/services/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Reviewservice {
  final Dio dio = Dio();
   final storage = const FlutterSecureStorage();
  Config configObj = Config();

  Future<Response> addReview({
    required String userid,
    required String hotelId,
    required String rating,
    required String review
  }) async {
   
     try {
      final response = await dio.post(
        "${configObj.url}addReviews",
        data: {
          'user_id': userid,
          'hotel_id': hotelId,
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
Future<List<Reviews>> getReviewsByHotel(String hotelId) async {
    try {
      final response = await dio.post(
        "${configObj.url}getReviewsByHotel",
        data: {'hotel_id': hotelId},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['reviews'];
        return data.map((json) => Reviews.fromJson(json)).toList();
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