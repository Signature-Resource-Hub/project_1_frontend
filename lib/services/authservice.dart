import 'package:dio/dio.dart';
import 'package:project_1_frontend/services/authservice.dart';
import 'package:project_1_frontend/services/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class AuthService {
  final Dio dio = Dio();
   final storage = const FlutterSecureStorage();
  Config configObj = Config();

  Future<Response> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone
  }) async {
    if (password != confirmPassword) {
      throw Exception('Passwords do not match.');
    }
     try {
      final response = await dio.post(
        "${configObj.url}register",
        data: {
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );
      return response;
    } catch (e) {
      print(e);
      throw Exception('Failed to register user: $e');
    }
  }
  
  Future<Map<String, dynamic>> userlogin(String email, String password) async {
    try {
      final response = await dio.post(
      "${configObj.url}login",
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        // Login successful, return response data
        return response.data;
      } else {
        // Handle other status codes (e.g., 401 for unauthorized)
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw e;
    }
  }
  
}
