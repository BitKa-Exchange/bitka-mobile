import 'package:bitka/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String get serviceUrl => '${AppConfig.apiBaseUrl}/v1/auth';

  late final Dio _dio;

  AuthService() {
    _dio = Dio(BaseOptions(
      baseUrl: serviceUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }


  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        // Save tokens
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', response.data['data']['access_token']);
        await prefs.setString('refresh_token', response.data['data']['refresh_token']);
        
        return {'success': true, 'message': 'Login successful'};
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Login failed'
        };
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return {
          'success': false,
          'message': 'Invalid username or password'
        };
      } else if (e.type == DioExceptionType.connectionTimeout) {
        return {'success': false, 'message': 'Connection timeout'};
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return {'success': false, 'message': 'Server not responding'};
      } else if (e.type == DioExceptionType.connectionError) {
        return {'success': false, 'message': 'Cannot connect to server'};
      } else {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'Network error: ${e.message}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        return {
          'success': true,
          'message': 'User registered successfully',
          'userId': response.data['data']?['user_id'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Registration failed'
        };
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return {
          'success': false,
          'message': 'Email already registered'
        };
      } else if (e.response?.statusCode == 422) {
        return {
          'success': false,
          'message': 'Invalid input: password must be at least 8 characters'
        };
      } else if (e.type == DioExceptionType.connectionTimeout) {
        return {'success': false, 'message': 'Connection timeout'};
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return {'success': false, 'message': 'Server not responding'};
      } else if (e.type == DioExceptionType.connectionError) {
        return {'success': false, 'message': 'Cannot connect to server'};
      } else {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'Network error'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    
    if (token != null) {
      try {
        await _dio.post(
          '/logout',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } catch (e) {
        // Ignore logout errors
      }
    }
    
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') != null;
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Get authenticated Dio instance for other API calls
  Future<Dio> getAuthenticatedDio() async {
    final token = await getAccessToken();
    final dio = Dio(BaseOptions(
      baseUrl: serviceUrl,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ));
    return dio;
  }
}