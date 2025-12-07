import 'package:bitka/features/wallet/deposit_screen.dart';
import 'package:bitka/features/wallet/transfer_screen.dart';
import 'package:bitka/features/wallet/withdraw_screen.dart';
import 'package:bitka/shared/widgets/coin_list_mock.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/icon_card.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/performance_card.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

import '../../shared/widgets/page_selector/wallet_history_control.dart';
import '../../shared/widgets/detailed_dropdown.dart';
import '../../shared/widgets/custom_chip.dart';
import '../../shared/widgets/button.dart';
import '../app_shell/app_shell_screen.dart'; 


class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // Use 'history' as the default view, matching the final design context
  SegmentedControlOption _currentTransactionView = SegmentedControlOption.history;

  // Placeholder data for transactions (taken from the second provided code block)
  final List<Map<String, dynamic>> _transactions = [
    {
      'date': '16 November 2025',
      'items': [
        {
          'type': 'Recieve',
          'time': '10.30 PM',
          'cryptoAmount': '0.012 BTC',
          'fiatAmount': '8,000 THB',
          'source': 'Binance',
        },
        {
          'type': 'Transferred',
          'time': '10.30 PM',
          'cryptoAmount': '0.005 BTC',
          'fiatAmount': '4,000 THB',
          'source': 'Self',
        },
      ]
    },
    {
      'date': '15 November 2025',
      'items': [
        {
          'type': 'Recieve',
          'time': '10.30 PM',
          'cryptoAmount': '0.5 ETH',
          'fiatAmount': '45,000 THB',
          'source': 'Coinbase',
        },
      ]
    },
  ];

Widget _buildWalletView() {
  final negativeTrend = [25.0, 20.0, 15.0, 8.0, 12.0, 10.0, 18.0, 14.0];
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // B. Wallet Value Card
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: PerformanceCard(
          data: PerformanceData(
            percentage: -92.0,
            value: 10293.01,
            chartData: negativeTrend,
          ),
        ),
      ),
      
      const SizedBox(height: 24),

      // C. Transaction Buttons - Full Width Container
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
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
                      }
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
                      onTap: () => debugPrint('Buy tapped!'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
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
  );
}

  // --- Widget for displaying the Transaction History List ---
  Widget _buildHistoryView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundBrandHover,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomChip(label: 'This month', onPressed: () {}),
              const SizedBox(width: 4), 
              CustomChip(label: 'All network', onPressed: () {}),
            ],
          ),
        ),
        const SizedBox(height: 16), 

        // Transaction List Container (from the second provided code block)
        Container(
          padding: const EdgeInsets.all(12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.backgroundBrandHover, // Using the explicit color from the design for this specific container
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _transactions.map((dateGroup) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0),
                    child: Text(
                      dateGroup['date'],
                      style: const TextStyle(
                        color: AppColors.textPrimary, 
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                      ),
                    ),
                  ),
                  ...dateGroup['items'].map<Widget>((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: DetailedButton(
                        text: item['type'],
                        subText: item['time'],
                        iconLeft: const Icon(Icons.star_rounded, color: AppColors.primaryPink, size: 32),
                        rightText: item['cryptoAmount'],
                        rightTextColor: item['type'] == 'Recieve' ? AppColors.utilityGreen : AppColors.utilityRed,
                        subRightText: item['fiatAmount'],
                        onTap: () {},
                      ),
                    );
                  }).toList(),
                  // Add spacing only if it's not the last group
                  if (dateGroup != _transactions.last) const SizedBox(height: 16), 
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      // Padding adjusted to account for the bottom navigation bar and screen edges
      padding: EdgeInsets.fromLTRB(32, 30, 32, 120 + bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Transaction',
                style: TextStyle(
                  color: AppColors.textPrimary, 
                  fontSize: 32,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  height: 1.40,
                ),
              ),
              WalletHistoryControl(
                onSelectionChanged: (selection) {
                  setState(() {
                    _currentTransactionView = selection;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16), 

          // 2. Nattan Niparnee Header Card
          DetailedDropDown(
            title: 'Nattan Niparnee',
            description: '123-XXXX-1234',
          ),
          const SizedBox(height: 16), 

          // 3. Dynamic Content based on selected view
          _currentTransactionView == SegmentedControlOption.wallet
              // ? _buildWalletView()
              ? _buildWalletView()
              : _buildHistoryView(),
        ],
      ),
    );
  }
}