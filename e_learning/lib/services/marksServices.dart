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

  Future<dynamic> postMarks(int user_id, int course_id, int marks) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.post(
        '/api/v3/set/marks?course_id=$course_id&user_id=$user_id&marks=$marks%',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful response
        return response.data;
      } else if (response.statusCode == 307) {
        String redirectUrl = response.headers['location']?.first ?? '';
        final redirectedResponse = await _dio.post(
          redirectUrl,
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
}
