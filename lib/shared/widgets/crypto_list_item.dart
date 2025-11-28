import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart'; 


class CoinData {
  final String symbol;
  final String name;
  final IconData icon; 
  final Color iconColor;
  final double price; // Price in THB (e.g., 18.3)
  final double change24h;
  final double balance; // Balance in crypto unit (e.g., 0.03)

  CoinData({
    required this.symbol,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.price,
    required this.change24h,
    required this.balance,
  });
}

// ===================================================================
// LIST ITEM WIDGET (The individual row)
// ===================================================================

class CryptoListItem extends StatelessWidget {
  final CoinData coin;

  const CryptoListItem({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = coin.change24h >= 0;
    // Maps the utility color based on the 24h change
    final Color trendColor = isPositive ? AppColors.utilityGreen : AppColors.utilityRed;
    final String sign = isPositive ? '+' : '';

    // The inner structure of the list item (one row)
    return Container(
      width: double.infinity,
      // Padding matches the 24px horizontal, 6px vertical from the snippet
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Side: Icon, Symbol, and Percentage Change
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Container (36x36 Circle)
              Container(
                width: 36,
                height: 36,
                decoration: const ShapeDecoration(
                  color: AppColors.textPrimary, // Used as a placeholder background color
                  shape: OvalBorder(),
                ),
                child: Icon(coin.icon, color: coin.iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              
              // Symbol and Percentage Stack
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Symbol (e.g., BNB)
                  Text(
                    coin.symbol,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      height: 1.40,
                    ),
                  ),
                  // 24h Change (e.g., +2.20%)
                  Text(
                    '$sign${coin.change24h.abs().toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: trendColor,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Right Side: Price and Balance
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Price (e.g., 18.3 THB)
              Text(
                '${coin.price.toStringAsFixed(1)} THB',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  height: 1.40,
                ),
              ),
              // Balance (e.g., 0.03 BNB)
              Text(
                '${coin.balance.toStringAsFixed(2)} ${coin.symbol}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.textSecondary, // Text-Neutral-Tertiary
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}