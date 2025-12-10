import 'package:bitka/services/market_data_service.dart';
import 'package:flutter/material.dart';

class MarketDataProvider with ChangeNotifier {
  final MarketDataService _service = MarketDataService();

  Map<String, dynamic>? candles;
  Map<String, dynamic>? orderbook;
  Map<String, dynamic>? price;

  bool isLoading = false;
  String? error;

  Future<void> fetchCandles(String symbol) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _service.getCandles(symbol);

    isLoading = false;
    if (result['success'] == true) {
      candles = result['data'];
    } else {
      error = result['message'];
    }

    notifyListeners();
  }

  Future<void> fetchOrderBook(String symbol) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _service.getOrderBook(symbol);

    isLoading = false;
    if (result['success'] == true) {
      orderbook = result['data'];
    } else {
      error = result['message'];
    }

    notifyListeners();
  }

  Future<void> fetchPrice(String symbol) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _service.getPrice(symbol);

    isLoading = false;
    if (result['success'] == true) {
      price = result['data'];
    } else {
      error = result['message'];
    }

    notifyListeners();
  }
}
