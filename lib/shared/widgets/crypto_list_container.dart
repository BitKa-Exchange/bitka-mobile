import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'crypto_list_item.dart';


class CryptoListContainer extends StatelessWidget {
  final List<CoinData> coins;

  const CryptoListContainer({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    // This container holds the list and mimics the visual card design
    return Container(
      width: double.infinity, // Takes available width
      height: 198, // Fixed height from your design
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        // Background color is dark surface
        color: AppColors.backgroundCardDefault, // Assuming 2C2C2C for the dark card background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: ListView.builder(
        // Add vertical padding for the top/bottom spacing inside the container
        padding: const EdgeInsets.symmetric(vertical: 8), 
        // Ensures the scroll bar appears only when necessary
        physics: const BouncingScrollPhysics(), 
        itemCount: coins.length,
        itemBuilder: (context, index) {
          // Use the detailed CryptoListItem for each row
          return CryptoListItem(coin: coins[index]);
        },
      ),
    );
  }
}