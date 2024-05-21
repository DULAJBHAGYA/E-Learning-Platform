import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'baseurl.dart';

class CourseService {
  late final Dio _dio;

  static final CourseService _instance = CourseService._internal();

  CourseService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static CourseService get instance => _instance;

  Future<dynamic> postCourse(FormData formData, int userId) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await _dio.post(
      '/api/v3/create/course/$userId',
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle successful response
      return response.data;
    } else if (response.statusCode == 307) {
      String redirectUrl = response.headers['location']?.first ?? '';
      final redirectedResponse = await _dio.post(
        redirectUrl,
        data: formData,
      );

      return redirectedResponse.data;
    } else {
      // Handle other status codes (e.g., 404, 500)
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




  Future<dynamic> fetchAllCourses() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('/api/v4/list/course');

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

  Future<dynamic> fetchCourseDetails(int course_id) async {
     try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('/api/v4/course?$course_id');

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
  
Future<dynamic> getCourseByUserId(int user_id) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

final response = await _dio.get('/api/v3/list/course/byuser?user_id=$user_id');

    return response.data;
  } on DioError catch (e) {
    print('Dio Error: $e');
    print('Dio Error Response: ${e.response}');
    print('Response Data: ${e.response?.data}');
    throw Exception('Error fetching courses: ${e.message}');
  } catch (e) {
    print('Unexpected Error: $e');
    rethrow;
  }
}




  postMaterial(String title, String description, int course_id) {}





  Future<dynamic> fetchCourseById(String course_id) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await _dio.get('/api/v4/course?$course_id');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to fetch course by ID. Status code: ${response.statusCode}');
    }
  } on DioError catch (e) {
    print("Dio Error: $e");
    print("Response Data: ${e.response?.data}");
    throw Exception(e.response?.data['detail'] ?? e.toString());
  } catch (e) {
    print("Unexpected Error: $e");
    rethrow;
  }
}



 
  enrollInCourse(int courseId, String username, String accessToken, String refreshToken) {}
}