import 'package:flutter/material.dart';
import '../services/orders_service.dart';

class OrdersProvider with ChangeNotifier {
  final OrdersService _service = OrdersService();

  bool isLoading = false;
  String? error;
  List<dynamic> orders = [];

  Future<void> fetchOrders() async {
    isLoading = true;
    notifyListeners();

    final result = await _service.getOrders();

    isLoading = false;
    if (result['success'] == true) {
      orders = result['data'];
      error = null;
    } else {
      error = result['message'];
    }

    notifyListeners();
  }

  Future<bool> placeOrder(String symbol, double size, String side) async {
    isLoading = true;
    notifyListeners();

    final result = await _service.placeOrder(symbol, size, side);

    isLoading = false;
    if (result['success'] == true) {
      await fetchOrders();
      return true;
    }

    error = result['message'];
    notifyListeners();
    return false;
  }

  Future<bool> cancelOrder(String id) async {
    final result = await _service.cancelOrder(id);

    if (result['success'] == true) {
      await fetchOrders();
      return true;
    }

    error = result['message'];
    notifyListeners();
    return false;
  }
}
