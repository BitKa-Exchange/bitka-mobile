import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/wallet/deposit_screen.dart';
import 'package:bitka/features/wallet/transfer_screen.dart';
import 'package:bitka/features/wallet/withdraw_screen.dart';
import 'package:bitka/shared/widgets/coin_list_mock.dart';
import 'package:bitka/shared/widgets/icon_card.dart';
import 'package:bitka/shared/widgets/detailed_dropdown.dart';
import 'package:bitka/shared/widgets/performance_card.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 160), // Space for Bottom Nav Bar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A. Header/Profile
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: _ProfileHeader(),
          ),
          
          const SizedBox(height: 24),
          
          // B. Wallet Value Card
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: _WalletValueSection(),
          ),
          
          const SizedBox(height: 24),

          // C. Transaction Buttons
          const _TransactionSection(),
          
          const SizedBox(height: 24),

          // D. Coins List Header
          const Padding(
            padding: EdgeInsets.only(left: 32, right: 32, bottom: 20),
            child: Text(
              'Coins',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          
          // E. Horizontal Coin List
          const CoinListMock(), 
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// 4. Individual Reusable Components (Widgets from previous steps)
// -------------------------------------------------------------------

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      // Use MainAxisAlignment.spaceBetween to push the two items to the edges
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 1. Logo Placeholder (Fixed size: 65x65 in original design, 
        // using your 134x134 but placed in a constrained container for safety)
        Container(
          width: 65,
          height: 50,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            // color: AppColors.primaryPink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover, // Ensure the image fits the 65x65 box
          ),
        ),

        const SizedBox(width: 16), // Add horizontal spacing between elements

        // 2. User Info/Dropdown Header (Fixed Width to prevent crash)
        SizedBox( // Use a SizedBox to constrain the width
          width: 216, // Use the width specified in the original design
          child: DetailedDropDown(
            title: 'Nattan Niparnee',
            description: '123-XXXX-1234',
          ),
        ),
      ],
    );
  }
}

// --- 4.2. Wallet Value Section (Performance Card) ---
class _WalletValueSection extends StatelessWidget {
  const _WalletValueSection();

  @override
  Widget build(BuildContext context) {
    final negativeTrend = [25.0, 20.0, 15.0, 8.0, 12.0, 10.0, 18.0, 14.0];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wallet Value',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        
        // Performance Card Widget (Defined below)
        PerformanceCard(
          data: PerformanceData(
            percentage: -92.0,
            value: 10293.01,
            chartData: negativeTrend,
          ),
        ),
      ],
    );
  }
}

// --- 4.3. Transaction Section ---
class _TransactionSection extends StatelessWidget {
  const _TransactionSection();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      // Use surfacePrimary (20161A) based on color palette
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Use the new reusable _buildTransactionCardWrapper
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5), 
                  child: IconCard(
                    icon: Icons.arrow_downward_rounded,
                    label: 'Deposit',
                    backgroundColor: AppColors.backgroundGradient2,
                    iconColor: AppColors.surfaceBorderPrimary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DepositScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5), 
                  child: IconCard(
                    icon: Icons.arrow_upward_rounded,
                    label: 'Withdraw',
                    backgroundColor: AppColors.backgroundGradient2,
                    iconColor: AppColors.surfaceBorderPrimary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WithdrawScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5), 
                  child: IconCard(
                    icon: Icons.send_rounded,
                    label: 'Transfer',
                    backgroundColor: AppColors.backgroundGradient2,
                    iconColor: AppColors.surfaceBorderPrimary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TransferScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5), 
                  child: IconCard(
                    icon: Icons.shopping_bag_outlined,
                    label: 'Buy',
                    backgroundColor: AppColors.backgroundGradient2,
                    iconColor: AppColors.surfaceBorderPrimary,
                    onTap: () { 
                      debugPrint('TODO: implement Buy Screen');
                    },
                  ),
                ),
              ),
              // _buildTransactionCardWrapper('Deposit', Icons.arrow_downward_rounded),
              // _buildTransactionCardWrapper('Withdraw', Icons.arrow_upward_rounded),
              // _buildTransactionCardWrapper('Transfer', Icons.send_rounded),
              // _buildTransactionCardWrapper('Buy', Icons.shopping_bag_outlined),
            ],
          ),
        ],
      ),
    );
  }
}