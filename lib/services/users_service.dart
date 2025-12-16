import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static String get baseUrl => '${dotenv.env['BASE_URL'] ?? 'http://127.0.0.1:8000'}/v1/users';

  late final Dio _dio;

  UserService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
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

  Future<Dio> _getAuthenticatedDio() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ));
    
    return dio;
  }

  // Get current user profile
  Future<Map<String, dynamic>> getMyProfile() async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.get('/me');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to fetch profile'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Update current user profile
  Future<Map<String, dynamic>> updateMyProfile(Map<String, dynamic> profileData) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.patch(
        '/me',
        data: profileData,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Profile update failed'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Get user profile by ID
  Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.get('/$userId');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'User not found'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Update user profile by ID
  Future<Map<String, dynamic>> updateUserById(
    String userId,
    Map<String, dynamic> profileData,
  ) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.patch(
        '/$userId',
        data: profileData,
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Profile update failed'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Change password
  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.post(
        '/me/change-password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Password changed successfully',
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Password change failed'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  Map<String, dynamic> _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return {'success': false, 'message': 'Unauthorized'};
    } else if (e.response?.statusCode == 404) {
      return {'success': false, 'message': 'User not found'};
    } else if (e.response?.statusCode == 400) {
      return {'success': false, 'message': 'Validation error'};
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
  }
}