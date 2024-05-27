import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/services/config.dart';

class BookingService {
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  final Config configObj = Config();

 Future<Map<String, dynamic>> createBooking(Map<String, dynamic> bookingData, String busId, String userId) async {
  try {
    // Check for null values in bookingData
    if (bookingData.values.any((value) => value == null)) {
      throw Exception('Booking data contains null values');
    }

    // Add busId and userId to the bookingData
    bookingData['busId'] = busId;
    bookingData['userId'] = userId;

    print('Booking Data: $bookingData');

    final response = await dio.post(
      "${configObj.url}createBooking",
      data: jsonEncode(bookingData),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = response.data;
      final String bookingId = responseData['bookingId']; // Extracting bookingId from response
      // Other necessary details can be extracted similarly if needed

      // Return the bookingId and other necessary details
      return {'bookingId': bookingId, ...responseData};
    } else {
      throw Exception('Failed to create booking: ${response.statusCode}');
    }
  } on DioError catch (e) {
    // Handle Dio errors
    if (e.response != null) {
      // DioError with a response
      print('Dio Error Response:');
      print('Status Code: ${e.response!.statusCode}');
      print('Error: ${e.message}');
      throw Exception('Failed to create booking: ${e.response!.statusCode}');
    } else {
      // DioError without a response
      print('Dio Error: ${e.message}');
      throw Exception('Failed to create booking: ${e.message}');
    }
  } catch (e) {
    // Handle other types of errors
    print('Error: $e');
    throw Exception('Failed to create booking: $e');
  }
}
}

