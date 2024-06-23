import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/services/config.dart';

class HotelService {
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  Config configObj = Config();
  
  

  getRoomByLocation(String location) async {
    final response = await dio.post(
      "${configObj.url}hotellocation",
      data: {
        'location': location,
        
      },
    );
    return response;
  }
}