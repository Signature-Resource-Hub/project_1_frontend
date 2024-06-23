import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/blogs.dart';
import 'package:project_1_frontend/services/configu.dart';

class BlogService {
static final Dio _dio = Dio();
  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static final Config _config = Config();

  static Future<List<Blog>> getblogs() async {
    try {
      final String apiUrl = "${_config.getUrl()}viewblog";
      print("API URL: $apiUrl"); // Debug print

      final response = await _dio.get(apiUrl);
      print("Response Status Code: ${response.statusCode}"); // Debug print
      print("Response Data: ${response.data}"); // Debug print

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data['data'];
        return jsonData.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load guides: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  } 

  getblogsByLocation(String location) async {
    final response = await _dio.post(
      "${_config.url}bloglocation",
      data: {
        'location': location,
        
      },
    );
    return response;
  }
}