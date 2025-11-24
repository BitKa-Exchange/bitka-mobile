import 'package:flutter/material.dart';
import 'home_page.dart';
import 'transactions/transaction_page.dart';
import 'account_page.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Market Page', style: TextStyle(color: Colors.white)),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(), // Index 0
    TransactionPage(), // Index 1
    MarketPage(), // Index 2
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Market'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Styling is handled in main.dart's theme
      ),
    );
  }
}
