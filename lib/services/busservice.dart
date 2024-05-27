import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/services/config.dart';

class BusService {
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  Config configObj = Config();

  getBusByLocation(String from, String to) async {
    final response = await dio.post(
      "${configObj.url}busbylocation",
      data: {
        'from': from,
        'to': to,
      },
    );
    return response;
  }
}
