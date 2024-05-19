import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';


class StudentService {
  late final Dio _dio;

  static final StudentService _instance = StudentService._internal();





  StudentService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true, 
      ),
    );
  }

  static StudentService get instance => _instance;


  
  Future<dynamic> fetchAllStudents() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('/api/v3/list/students?page_id=1&page_size=100');

      return response.data;
    } on DioError catch (e) {
      print("Dio Error: $e");
      print("Response Data: ${e.response?.data}");
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }
}