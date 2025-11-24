import 'package:flutter/material.dart';
import '../main.dart';

class TransferTab extends StatelessWidget {
  const TransferTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Transferor',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // Transferor Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: darkCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.purpleAccent, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'ETH',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Available Credit',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '0.67 ETH',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '1,210 THB',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Amount Input
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Amount',
              hintStyle: TextStyle(color: Colors.grey[600]),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'ETH',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              filled: true,
              fillColor: darkCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Receiver Label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Receiver',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.qr_code_scanner, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          // Address Input
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Address',
              hintStyle: TextStyle(color: Colors.grey[600]),
              suffixIcon: const Icon(Icons.copy, color: Colors.grey),
              filled: true,
              fillColor: darkCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 100), // Spacer
          // Next Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/transactions/confirmation');
            },
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
