import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baseurl.dart';

class AdminService {
  late final Dio _dio;

  static final AdminService _instance = AdminService._internal();



  AdminService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true, // Add this line
      ),
    );
  }

  static AdminService get instance => _instance;

  Future<dynamic> poastAdmin(String role, String email,
      String first_name, String last_name, String hashed_password, String user_name) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(
          'access_token'); 

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] =
          'Bearer $accessToken'; 

      final response = await _dio.post(
        '/api/v1/signup',
        data: {
          "first_name": first_name,
          "last_name": last_name,
          "email": email,
          "user_name": user_name,
          "role": role,
          "hashed_password": hashed_password,
        },
      );

      if (response.statusCode == 307) {
        String redirectUrl = response.headers['location']?.first ?? '';
        final redirectedResponse = await _dio.post(
          redirectUrl,
          data: {
            "first_name": first_name,
            "last_name": last_name,
            "email": email,
            "user_name": user_name,
            "role": role,
            "hashed_password": hashed_password,
          },
        );

        return redirectedResponse.data;
      }

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

  Future<dynamic> fetchAllAdmins() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('/listadmin?page_id=1&page_size=10');

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

  Future<dynamic> updateAdmin(
  String email,
  String full_name,
  String password,
  String user_name,
) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await _dio.put(
      '/user/edit', 
      data: {
        "full_name": full_name,
        "email": email,
        "hashed_password": password,
        "user_name": user_name,
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