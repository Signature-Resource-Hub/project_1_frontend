import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/post.dart';
import 'package:project_1_frontend/services/configu.dart';
import 'package:http/http.dart' as http;

class updateservice {
  final dio = Dio();
  final storage = const FlutterSecureStorage();
  Config configObj = Config();

  Future<Response> getUser(String userid) async {
    try {
      final response = await dio.post("${configObj.url}getUser", data: {"userId": '6603b02fea5695ab5c189768'});
      return response;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }
  editusername(String editUserName) async {
    final response = await dio.post(
      "${configObj.url}register",
      data: editUserName,
    );
    return response;
  }

  editemail(String editEmail) async {
    final response = await dio.post(
      "${configObj.url}updateEmail",
      data: editEmail,
    );
    return response;
  }

  editphone(String editPhone) async {
    final response = await dio.post(
      "${configObj.url}updatePhone",
      data: editPhone,
    );
    return response;
  }

  Future<Response> updatePassword(String userId, String currentPassword, String newPassword) async {
  try {
    // Make API call to update password
    final response = await dio.post(
      '${configObj.url}updatePass',
      data: {
        '_id': userId,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
    return response;
  } catch (error) {
    // Handle error
    print('Error updating password: $error');
    throw error;
  }
}

}

class PostApiService {
  final Config config = Config();
Future<List<Hotel>> getHotel(String location, String acNonAc, double cost) async {
  try {
    var apiUrl = Uri.parse(config.hotelflaskUrl);
    var response = await http.post(
      apiUrl,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, dynamic>{
        "location": location,
        
        "acNonAc": acNonAc,
        "cost": cost,
        
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response body into a list of hotel objects
      print("Got data");
      print(response.body);
      return hotelFromJson(response.body);
    } else {
      // Return an empty list if the status code is not 200
      return [];
    }
  } catch (e) {
    // Print error message if there's an exception
    print("Error fetching hotel data: $e");
    return []; // Return an empty list if there's an error
  }
}
}






