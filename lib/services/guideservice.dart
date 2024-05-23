


import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/guidemodel.dart';
import 'package:project_1_frontend/services/config.dart';

class GuideService {
  static final Dio _dio = Dio();
  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static final Config _config = Config();

  static Future<List<Guide>> getGuides() async {
    try {
      final String apiUrl = "${_config.getUrl()}view";
      print("API URL: $apiUrl"); // Debug print

      final response = await _dio.get(apiUrl);
      print("Response Status Code: ${response.statusCode}"); // Debug print
      print("Response Data: ${response.data}"); // Debug print

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data['data'];
        return jsonData.map((json) => Guide.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load guides: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

   getguideByLocation(String location )async {
    final response = await _dio.post(
      "${_config.url}getguideByLocation",
      data: {
        'location': location,
       
      },
    );
    return response;
  }
}
