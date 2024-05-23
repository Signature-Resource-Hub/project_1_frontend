import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/hotel.dart';
import 'package:project_1_frontend/models/order.dart';
import 'package:project_1_frontend/models/orderdetails.dart';
//import 'package:project_1_frontend/model/busbook.dart';
import 'config.dart';


class DisplayService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Config _configObj = Config();

  // Future<List<Hotel>> getBookingsByUserId(String userId) async {
  //   try {
  //     final response = await _dio.post(
  //       '${_configObj.url}/order',
  //       data: {'userid': userId},
  //     );

  //     if (response.statusCode == 200) { 
  //       List<Hotel> bookings = (response.data['bookings'] as List)
  //           .map((bookings) => Hotel.fromJson(bookings))
  //           .toList();
  //       return bookings;
  //     } else {
  //       throw Exception('Failed to load bookings');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  // Future<List<Map<String, dynamic>>> getCancelledBookingsByUserId(String userId) async {
  //   try {
  //     final response = await _dio.post(
  //       '${_configObj.url}/canceldetails',
  //       data: {'userId': userId},
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data['Order'];
  //       List<Map<String, dynamic>> Order = [];
  //       for (var item in data) {
  //         Order.add(Map<String, dynamic>.from(item));
  //       }
  //       return Order;
  //     } else {
  //       throw Exception('Failed to load cancelled bookings');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  //wrking

//   Future<List<Map<String, dynamic>>> getCancelledBookingsByUserId(String userId) async {
//   try {
//     final response = await _dio.post(
//       '${_configObj.url}/canceldetails',
//       data: {'userId': userId},
//     );

//     if (response.statusCode == 200) {
//       final dynamic data = response.data;
//       if (data != null && data is Map<String, dynamic>) {
//         if (data.containsKey('cancelledBookings')) {
//           final List<dynamic> cancelledBookingsData = data['cancelledBookings'];
//           List<Map<String, dynamic>> cancelledBookings = cancelledBookingsData.map((item) => Map<String, dynamic>.from(item)).toList();
//           return cancelledBookings;
//         } else {
//           throw Exception('Cancelled bookings not found in response data');
//         }
//       } else {
//         throw Exception('Invalid response data format');
//       }
//     } else {
//       throw Exception('Failed to load cancelled bookings');
//     }
//   } catch (e) {
//     throw Exception('Error: $e');
//   }
// }

Future<List<Map<String, dynamic>>> getCancelledBookingsByUserId(String userId) async {
    try {
      final response = await _dio.post(
        '${_configObj.url}/canceldetails',
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['cancelledBookings'];
        List<Map<String, dynamic>> cancelledBookings = [];
        for (var item in data) {
          cancelledBookings.add(Map<String, dynamic>.from(item));
        }
        return cancelledBookings;
      } else {
        throw Exception('Failed to load cancelled bookings');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  Future<void> cancelBooking(String bookingId) async {
    try {
      final response = await _dio.post(
        '${_configObj.url}/cancel',
        data: {'bookingId': bookingId},
      );

      if (response.statusCode == 200) {
        // Booking cancellation successful
        return;
      } else {
        throw Exception('Failed to cancel booking');
      }
    } catch (e) {
      throw Exception('Error cancelling booking: $e');
    }
  }

//   Future<Map<String, dynamic>> cancelBooking(String bookingId) async {
//   try {
//     final response = await _dio.post(
//       '${_configObj.url}/cancel',
//       data: {'bookingId': bookingId},
//     );

//     if (response.statusCode == 200) {
//       // Return the updated booking details
//       return response.data['updatedBooking']; // Adjust the key based on the response structure
//     } else {
//       throw Exception('Failed to cancel booking');
//     }
//   } catch (e) {
//     throw Exception('Error cancelling booking: $e');
//   }
// }



  Future<List<Display>> getBookingsByUserId(String userId) async {
  try {
    final response = await _dio.post(
      '${_configObj.url}/order',
      data: {'userid': userId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['bookings'];
      List<Display> bookings = data.map((booking) => Display.fromJson(booking)).toList();
      return bookings;
    } else {
      throw Exception('Failed to load bookings');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
}

