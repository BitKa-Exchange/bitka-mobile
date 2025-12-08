import 'package:bitka/shared/widgets/coin_card.dart';
import 'package:bitka/shared/widgets/coin_list.dart';
import 'package:flutter/material.dart';

class CoinListMock extends StatelessWidget {
  const CoinListMock({super.key});

  // Helper function to generate a list of CoinCard widgets
  List<CoinCard> _getMockCoinCards() {
    // Define the mock data directly as a list of arguments for CoinCard
    final List<Map<String, dynamic>> mockData = [
      {
        'title': 'BNB',
        'icon': Container(color: Colors.white),
        'price': 388.92,
        'quantity': 0.03,
        'percent': 2.20,
        'priceCurrency': 'USD',
        'quantityCurrency': 'BNB',
      },
      {
        'title': 'ETH',
        'icon': Container(color: Colors.white),
        'price': 2500.50,
        'quantity': 0.5,
        'percent': -1.50,
        'priceCurrency': 'USD',
        'quantityCurrency': 'ETH',
      },
      {
        'title': 'XRP',
        'icon': Container(color: Colors.white),
        'price': 0.55,
        'quantity': 1000.0,
        'percent': 0.1,
        'priceCurrency': 'USD',
        'quantityCurrency': 'XRP',
      },
      {
        'title': 'ADA',
        'icon': Container(color: Colors.white),
        'price': 0.8,
        'quantity': 500.0,
        'percent': 3.5,
        'priceCurrency': 'USD',
        'quantityCurrency': 'ADA',
      },
      {
        'title': 'SOL',
        'icon': Container(color: Colors.white),
        'price': 150.00,
        'quantity': 2.5,
        'percent': 5.10,
        'priceCurrency': 'USD',
        'quantityCurrency': 'SOL',
      },
      {
        'title': 'DOGE',
        'icon': Container(color: Colors.white),
        'price': 0.20,
        'quantity': 10000.0,
        'percent': -0.50,
        'priceCurrency': 'USD',
        'quantityCurrency': 'DOGE',
      },
    ];

    // Map the mock data to CoinCard widgets
    return mockData.map((data) {
      return CoinCard(
        title: data['title'] as String,
        icon: data['icon'] as Widget,
        price: data['price'] as double,
        quantity: data['quantity'] as double,
        percent: data['percent'] as double,
        priceCurrency: data['priceCurrency'] as String,
        quantityCurrency: data['quantityCurrency'] as String,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Generate the list of CoinCard widgets
    final List<CoinCard> coinCards = _getMockCoinCards();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      // Use the CoinList widget and pass the generated CoinCard children
      child: CoinList(children: coinCards),
    );
  }
}