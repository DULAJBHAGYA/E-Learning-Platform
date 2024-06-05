import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';

class SubmissionService {
  late final Dio _dio;

  static final SubmissionService _instance = SubmissionService._internal();

  SubmissionService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static SubmissionService get instance => _instance;

  Future<dynamic> postSubmission(
      FormData file, int assignment_id, int user_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.post(
        '/api/v4/create/submission/$assignment_id/$user_id',
        data: file,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 307) {
        String redirectUrl = response.headers['location']?.first ?? '';
        final redirectedResponse = await _dio.post(
          redirectUrl,
          data: file,
        );

        return redirectedResponse.data;
      } else {
        throw Exception(
            'Failed to post course. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception('Course not found. Please check your request.');
      } else {
        print("Dio Error: $e");
        print("Response Data: ${e.response?.data}");
        throw Exception(e.response?.data['detail'] ?? e.toString());
      }
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<dynamic> fetchAssignmentDetails(
      int course_id, int assignment_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await _dio.get(
          '/api/v4/get/assignment/bycourse?assignment_id=$assignment_id&course_id=$course_id');

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

  Future<dynamic> deleteCourseById(int course_id) async {
    try {
      final response = await _dio.delete('/course/$course_id');

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

  Future<dynamic> updateCourseById(
      int course_id, String title, String description, String type) async {
    try {
      final response = await _dio.put(
        '/course/$course_id',
        data: jsonEncode({
          'title': title,
          'description': description,
          'type': type,
        }),
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

  Future<dynamic> getSubmissionsByAdminId(int user_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      Map<String, dynamic> headers = {};
      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await _dio.get(
        '/api/v3/list/submission?user_id=$user_id',
        options: Options(headers: headers),
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
