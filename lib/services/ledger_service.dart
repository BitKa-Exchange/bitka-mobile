import 'package:bitka/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LedgerService {
  static String get baseUrl => '${AppConfig.apiBaseUrl}/v1/ledger';

  late final Dio _dio;

  LedgerService() {
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

  // Get ledger accounts
  Future<Map<String, dynamic>> getAccounts({
    int page = 1,
    int perPage = 25,
    String? userId,
    String? asset,
  }) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.get(
        '/accounts',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (userId != null) 'user_id': userId,
          if (asset != null) 'asset': asset,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to fetch accounts'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Get account by ID
  Future<Map<String, dynamic>> getAccountById(String accountId) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.get('/accounts/$accountId');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Account not found'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Get transactions
  Future<Map<String, dynamic>> getTransactions({
    int page = 1,
    int perPage = 25,
    String? accountId,
    String? asset,
    String? status,
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.get(
        '/transactions',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (accountId != null) 'account_id': accountId,
          if (asset != null) 'asset': asset,
          if (status != null) 'status': status,
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to fetch transactions'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Create transaction
  Future<Map<String, dynamic>> createTransaction({
    required Map<String, dynamic> transactionData,
    String? idempotencyKey,
  }) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.post(
        '/transactions',
        data: transactionData,
        options: Options(
          headers: {
            if (idempotencyKey != null) 'Idempotency-Key': idempotencyKey,
          },
        ),
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Transaction creation failed'
        };
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  // Get transaction by ID
  Future<Map<String, dynamic>> getTransactionById(String transactionId) async {
    try {
      final dio = await _getAuthenticatedDio();
      final response = await dio.get('/transactions/$transactionId');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Transaction not found'
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
      return {'success': false, 'message': 'Not found'};
    } else if (e.response?.statusCode == 409) {
      return {'success': false, 'message': 'Conflict'};
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