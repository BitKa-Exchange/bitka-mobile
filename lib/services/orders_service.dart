import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersService {
  static String get serviceUrl =>
      '${dotenv.env['BASE_URL'] ?? 'http://127.0.0.1:8000'}/v1/orders';

  Future<Dio> _getAuthDio() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    return Dio(BaseOptions(
      baseUrl: serviceUrl,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ));
  }

  Future<Map<String, dynamic>> placeOrder(
      String symbol, double size, String side) async {
    try {
      final dio = await _getAuthDio();
      final response = await dio.post('/create', data: {
        'symbol': symbol,
        'size': size,
        'side': side,
      });

      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Order failed'};
    }
  }

  Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    try {
      final dio = await _getAuthDio();
      final response = await dio.post('/cancel/$orderId');
      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Cancel failed'};
    }
  }

  Future<Map<String, dynamic>> getOrders() async {
    try {
      final dio = await _getAuthDio();
      final response = await dio.get('/all');
      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Failed to get orders'};
    }
  }
}
