import 'package:bitka/app_config.dart';
import 'package:dio/dio.dart';

class MarketDataService {
  static String get serviceUrl =>
      '${AppConfig.apiBaseUrl}/v1/marketdata';

  late final Dio _dio;

  MarketDataService() {
    _dio = Dio(BaseOptions(
      baseUrl: serviceUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  Future<Map<String, dynamic>> getCandles(String symbol) async {
    try {
      final response = await _dio.get('/candles/$symbol');

      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch candles'};
    }
  }

  Future<Map<String, dynamic>> getOrderBook(String symbol) async {
    try {
      final response = await _dio.get('/orderbook/$symbol');
      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch orderbook'};
    }
  }

  Future<Map<String, dynamic>> getPrice(String symbol) async {
    try {
      final response = await _dio.get('/price/$symbol');
      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch price'};
    }
  }
}
