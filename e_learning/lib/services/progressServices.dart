import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';

class ProgressService {
  late final Dio _dio;

  static final ProgressService _instance = ProgressService._internal();

  ProgressService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static ProgressService get instance => _instance;

  Future<dynamic> editProgress({
    required bool completed,
    required int course_id,
    required int user_id,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.put(
        '/api/v4/edit/progress?course_id=$course_id&user_id=$user_id&completed=$completed',
        data: {
          'user_id': user_id,
          'course_id': course_id,
          'completed': completed,
        },
      );

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

  Future<dynamic> gteProgress({
    required int user_id,
    required int course_id,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get(
        '/api/v4/get/progress?user_id=$user_id&course_id=$course_id',
      );

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
