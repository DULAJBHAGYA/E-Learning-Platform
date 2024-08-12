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
            'Failed to post submission. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception('Submission not found. Please check your request.');
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

  Future<dynamic> deleteSubmission(int user_id, int assignment_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.delete(
          '/api/v4/del/submission?assignment_id=$assignment_id&user_id=$user_id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else if (response.statusCode == 307) {
        String redirectUrl = response.headers['location']?.first ?? '';
        final redirectedResponse = await _dio.delete(redirectUrl);

        return redirectedResponse.data;
      } else {
        throw Exception(
            'Failed to delete submission. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception('Submission not found. Please check your request.');
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

  Future<dynamic> editSubmission(
      FormData file, int user_id, int assignment_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.patch(
        '/api/v4/edit/submission/byuser/$assignment_id/$user_id',
        data: file,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else if (response.statusCode == 307) {
        String redirectUrl = response.headers['location']?.first ?? '';
        final redirectedResponse = await _dio.patch(
          redirectUrl,
          data: file,
        );

        return redirectedResponse.data;
      } else {
        throw Exception(
            'Failed to edit submission. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception('Submission not found. Please check your request.');
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

  Future<dynamic> fetchSubmissionDetails(
      int course_id, int assignment_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await _dio.get(
          '/api/v3/get/submission?assignment_id=$assignment_id&user_id=$course_id');

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
