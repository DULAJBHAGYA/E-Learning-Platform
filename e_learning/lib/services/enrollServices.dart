import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';

class EnrollService {
  late final Dio _dio;

  static final EnrollService _instance = EnrollService._internal();

  EnrollService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static EnrollService get instance => _instance;

  Future<dynamic> postEnrollment(int user_id, int course_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.post(
        '/api/v4/create/subscription?user_id=$user_id&course_id=$course_id',
        data: {
          "user_id": user_id,
          "course_id": course_id,
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

  Future<dynamic> fetchAllEnrollments() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('/api/v3/list/subscriptions');

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

  Future<dynamic> editEnrollment({
    required int user_id,
    required bool active,
    required bool pending,
    required int course_id,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.patch(
        '/api/v4/edit/subscription?user_id=$user_id&course_id=$course_id&active=$active&pending=$pending',
        data: {
          "user_id": user_id,
          "active": active,
          "pending": pending,
          "course_id": course_id,
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

  Future<dynamic> deleteSubscriptionRequest(int user_id) async {
    try {
      final response = await _dio.delete('/api/v3/del/status?$user_id');

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

  Future<dynamic> fetchEnrollmentbyUserIdnCourseId(
      int user_id, int course_id, String accessToken) async {
    try {
      final response = await _dio.get(
        '/api/v4/get/subscription?user_id=$user_id&course_id=$course_id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data;
    } catch (e) {
      print('Error fetching user info for username: $user_id - $e');
      throw e;
    }
  }
}
