import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';

class UserService {
  late final Dio _dio;

  static final UserService _instance = UserService._internal();

  UserService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static UserService get instance => _instance;

//method for registering a student
  Future<dynamic> registerUser(
      String first_name,
      String last_name,
      String user_name,
      String email,
      String hashed_password,
      String role) async {
    try {
      final response = await _dio.post(
        '/api/v1/signup',
        data: jsonEncode({
          'first_name': first_name,
          'last_name': last_name,
          'user_name': user_name,
          'email': email,
          'hashed_password': hashed_password,
          'role': role,
        }),
      );

      if (response.statusCode == 307) {
        String redirectUrl = response.headers['location']?.first ?? '';

        final redirectedResponse = await _dio.post(
          redirectUrl,
          data: jsonEncode({
            'first_name': first_name,
            'last_name': last_name,
            'user_name': user_name,
            'email': email,
            'hashed_password': hashed_password,
            'role': role,
          }),
        );

        return redirectedResponse.data;
      }

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

//user login method
  Future<Map<String, dynamic>> loginUser(
      String user_name, String hashed_password) async {
    try {
      final response = await _dio.post(
        '/api/v1/login',
        data: {
          'user_name': user_name,
          'hashed_password': hashed_password,
        },
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

//display user info by username method
  Future<dynamic> fetchUsersById(int user_id, String accessToken) async {
    try {
      final response = await _dio.get(
        '/api/v2/get/user?user_id=$user_id',
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

//update user info methodupdate user method
  Future<Map<String, dynamic>> updateUser({
    required int user_id,
    required String email,
    required String first_name,
    required String last_name,
    required String user_name,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.patch(
        '/api/v2/edit/user',
        data: {
          'user_id': user_id,
          "first_name": first_name,
          'last_name': last_name,
          "user_name": user_name,
          'email': email,
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

//delete user method
  Future<dynamic> deleteUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.delete(
        '/del/user',
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
