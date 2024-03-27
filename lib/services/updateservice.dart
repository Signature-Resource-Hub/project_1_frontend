import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/services/configu.dart';

class updateservice {
  final dio = Dio();
  final storage = const FlutterSecureStorage();
  Config configObj = Config();

  Future<Response> getUser(String userid) async {
    try {
      final response = await dio.post("${configObj.url}getUser", data: {"userId": '6601a12265a5ae70d4022d2e'});
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
