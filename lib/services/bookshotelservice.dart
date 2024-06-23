import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/post.dart';
import 'package:project_1_frontend/services/configu.dart';
import 'package:http/http.dart' as http;

class UserService {
  final Dio dio;

  UserService(this.dio);

  Future<Response> getUser(String userid) async {
    try {
      return await dio.get('/user/$userid');
    } catch (e) {
      // Handle error appropriately
      throw Exception('Failed to get user details: $e');
    }
  }
}