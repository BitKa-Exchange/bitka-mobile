import 'package:flutter/material.dart';
import 'main.dart'; // For color constants

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(),
              const SizedBox(height: 24),
              _buildWalletValueCard(),
              const SizedBox(height: 24),
              _buildTransactionSection(),
              const SizedBox(height: 24),
              _buildMyCoinsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Top app bar with user info
  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        Image.asset('assets/logo.png', height: 60),
        // User Info Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: primaryPink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // <-- Removed 'const'
              Column(
                // <-- Use a Column to stack the text
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Nattan Niparnee',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // <-- Added the new Text widget
                    '123-xxxx-1234',
                    style: TextStyle(
                      color: Colors.white70, // Added a style
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }

  // "Wallet Value" card with mock graph
  Widget _buildWalletValueCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wallet Value',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  '-92%',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '~ 10,293.01 THB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Mock Graph
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: darkBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '[Mock Graph Area]',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // "Transaction" section with four buttons
  Widget _buildTransactionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTransactionButton(Icons.arrow_downward, 'Deposit'),
            _buildTransactionButton(Icons.arrow_upward, 'Withdraw'),
            _buildTransactionButton(Icons.send, 'Transfer'),
            _buildTransactionButton(Icons.attach_money, 'Buy'),
          ],
        ),
      ],
    );
  }

  // Helper for transaction buttons
  Widget _buildTransactionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: darkCard,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  // "My coins" section with a mock list
  Widget _buildMyCoinsSection() {
    // Mock data for the coin list
    final List<Map<String, String>> myCoins = [
      {
        'name': 'BNB',
        'amount': '18.3 THB',
        'change': '+2.20%',
        'bnb': '0.03 BNB',
      },
      {
        'name': 'BNB',
        'amount': '18.3 THB',
        'change': '+2.20%',
        'bnb': '0.03 BNB',
      },
      {
        'name': 'BNB',
        'amount': '18.3 THB',
        'change': '+2.20%',
        'bnb': '0.03 BNB',
      },
      {
        'name': 'BNB',
        'amount': '18.3 THB',
        'change': '+2.20%',
        'bnb': '0.03 BNB',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My coins',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Building the list from mock data
        ListView.builder(
          itemCount: myCoins.length,
          shrinkWrap: true, // Important inside a SingleChildScrollView
          physics:
              const NeverScrollableScrollPhysics(), // Disables scrolling for the list itself
          itemBuilder: (context, index) {
            final coin = myCoins[index];
            return _buildCoinListItem(coin);
          },
        ),
      ],
    );
  }

  // Helper for a single item in the "My coins" list
  Widget _buildCoinListItem(Map<String, String> coin) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Coin Icon Placeholder
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white, // Placeholder
              child: Text(
                'B',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Coin Name and Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  coin['change']!,
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            const Spacer(),
            // Amount in THB and BNB
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  coin['amount']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(coin['bnb']!, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
