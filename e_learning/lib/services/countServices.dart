import 'package:dio/dio.dart';

import 'baseurl.dart';

class CountService {
  late final Dio _dio;

  static final CountService _instance = CountService._internal();

  CountService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static CountService get instance => _instance;

  Future<dynamic> fetchCourseDetails() async {
    try {
      final response = await _dio.get('/api/v3/all/counts');

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
