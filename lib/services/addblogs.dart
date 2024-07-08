import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:project_1_frontend/services/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/services/authservice.dart';
import 'package:project_1_frontend/services/config.dart';
import 'package:http/http.dart' as http;


class BlogService {
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  Config configObj = Config();

  Future<Response> addBlog({
    required String userid,
    required String content,
    required String location,
  }) async {
    try {
      final response = await dio.post(
        "${configObj.url}addblog", // Update this with your actual endpoint
        data: {
          'userid': userid,
          'content': content,
          'location': location,
        },
      );
      return response;
    } catch (e) {
      print(e);
      throw Exception('Failed to add blog: $e');
    }
  }

Future<Response> editBlog({
  required String blogId,
  required String content,
  required String location,
}) async {
  try {
    final response = await dio.put(
      "${configObj.url}editblog", // Update this with your actual endpoint
      data: {
        'blogId': blogId,
        'content': content,
        'location': location,
      },
    );
    return response;
  } catch (e) {
    print(e);
    throw Exception('Failed to edit blog: $e');
  }
}




Future<List<dynamic>> fetchUserBlogs(String userId) async {
  try {
    final response = await dio.post(
       "${configObj.url}blogsbyuserid",
      data: {'userid': userId},
    );
    if (response.statusCode == 200) {
      // Assuming 'data' is the key containing the list of blogs in the response map
      final List<dynamic> blogs = response.data['data'];
      return blogs;
    } else if(response.statusCode==404)
    {
      final List<dynamic> blogs = response.data['data'];
      return blogs;
    }
    else
    {
      throw Exception('Failed to load blogs');
    }

  } catch (e) {
    print(e);
    throw Exception('Failed to load blogs: $e');
  }
}


Future<void> deleteBlog(String blogId) async {
  try {
    final response = await dio.post(
      "${configObj.url}deleteBlog", // Update this with your actual endpoint
      data: {'blogId': blogId},
    );
    if (response.statusCode == 200) {
      // Blog deleted successfully
      return;
    } else {
      throw Exception('Failed to delete blog');
    }
  } catch (e) {
    print(e);
    throw Exception('Failed to delete blog: $e');
  }
}


 
}