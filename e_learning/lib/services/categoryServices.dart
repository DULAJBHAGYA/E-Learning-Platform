import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'baseurl.dart';

class CategoryServices {
  late final Dio _dio;

  static final CategoryServices _instance = CategoryServices._internal();

  CategoryServices._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 6000000),
        receiveTimeout: Duration(milliseconds: 6000000),
        followRedirects: true,
      ),
    );
  }

  static CategoryServices get instance => _instance;

  Future<dynamic> postCatagory(String catagory) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.post(
        '/api/v3/create/catagory?catagory=$catagory',
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

  Future<dynamic> fetchAllCategories() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('/api/v3/list/catagories');

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
