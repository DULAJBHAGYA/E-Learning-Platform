import 'package:dio/dio.dart';

import 'baseurl.dart';

class EmailService {
  late final Dio _dio;

  static final EmailService _instance = EmailService._internal();

  EmailService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static EmailService get instance => _instance;

  Future<Map<String, dynamic>> checkEmail(String email) async {
    try {
      final response = await _dio.get(
        '/api/v1/check/email?email=$email',
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.message);
    } catch (e) {
      rethrow;
    }
  }
}
