import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';

class Passwordservice {
  late final Dio _dio;

  static final Passwordservice _instance = Passwordservice._internal();

  Passwordservice._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static Passwordservice get instance => _instance;

  Future<dynamic> editPassword({
    required String current_password,
    required String hashed_password,
    required String confirm_password,
    required int user_id,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.patch(
        '/api/v2/edit/password',
        data: {
          'user_id': user_id,
          'current_password': current_password,
          'hashed_password': hashed_password,
          'confirm_password': confirm_password,
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
}
