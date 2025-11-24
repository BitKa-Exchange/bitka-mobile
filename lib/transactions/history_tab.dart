import 'package:flutter/material.dart';
import '../main.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Buttons
          Row(
            children: [
              _buildFilterChip('This month'),
              const SizedBox(width: 12),
              _buildFilterChip('All network'),
            ],
          ),
          const SizedBox(height: 24),
          // Date Header
          const Text('16 November 2025', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          // List Items
          _buildHistoryItem(
            type: 'Receive',
            fromTo: 'From Somchai Saichom',
            amount: '1231.21 ETH',
            thb: '112,131.13 THB',
            isPositive: true,
          ),
          _buildHistoryItem(
            type: 'Receive',
            fromTo: 'From Unknown', // Placeholder
            amount: '1231.21 ETH',
            thb: '112,131.13 THB',
            isPositive: true,
          ),
          const SizedBox(height: 24),
          const Text('15 November 2025', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildHistoryItem(
            type: 'Transferred',
            fromTo: '10:08 PM',
            amount: '1231.21 ETH',
            thb: '112,131.13 THB',
            isPositive: false,
          ),
           _buildHistoryItem(
            type: 'Transferred',
            fromTo: '10:08 PM',
            amount: '1231.21 ETH',
            thb: '112,131.13 THB',
            isPositive: false,
          ),
           _buildHistoryItem(
            type: 'Transferred',
            fromTo: '10:08 PM',
            amount: '1231.21 ETH',
            thb: '112,131.13 THB',
            isPositive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(text, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String type,
    required String fromTo,
    required String amount,
    required String thb,
    required bool isPositive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.purpleAccent, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(fromTo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isPositive ? '+$amount' : '-$amount',
                style: TextStyle(
                  color: isPositive ? Colors.greenAccent : primaryPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(thb, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}