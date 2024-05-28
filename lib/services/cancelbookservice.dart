import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/model/busbook.dart';
import 'config.dart';


class ViewService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Config _configObj = Config();

  Future<List<Busbookings>> getBookingsByUserId(String userId) async {
    try {
      final response = await _dio.post(
        '${_configObj.url}/getBookingsByUserId',
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        List<Busbookings> bookings = (response.data['bookings'] as List)
            .map((booking) => Busbookings.fromJson(booking))
            .toList();
        return bookings;
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCancelledBookingsByUserId(String userId) async {
    try {
      final response = await _dio.post(
        '${_configObj.url}/getCancelledBookingsByUserId',
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
        '${_configObj.url}/cancelBooking',
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
}


