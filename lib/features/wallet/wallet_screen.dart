import 'package:bitka/shared/widgets/migrate/detailed_button.dart';
import 'package:bitka/shared/widgets/migrate/input_field.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

import '../../shared/widgets/transfer_history_control.dart'; 
import '../../shared/widgets/migrate/detailed_dropdown.dart'; 
import '../../shared/widgets/filter_option_chip.dart'; 
import '../../shared/widgets/transaction_list_item.dart'; 
import '../../shared/widgets/migrate/button.dart';
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
          'type': TransactionType.receive,
          'time': '10.08 PM',
          'cryptoAmount': '1231.21 ETH',
          'fiatAmount': '112,131.13 THB',
          'source': 'Somchai Saichom',
        },
        {
          'type': TransactionType.receive,
          'time': '10.08 PM',
          'cryptoAmount': '1231.21 ETH',
          'fiatAmount': '112,131.13 THB',
        },
      ],
    },
    {
      'date': '15 November 2025',
      'items': [
        {
          'type': TransactionType.transferred,
          'time': '10.08 PM',
          'cryptoAmount': '1231.21 ETH',
          'fiatAmount': '112,131.13 THB',
        },
        {
          'type': TransactionType.transferred,
          'time': '10.08 PM',
          'cryptoAmount': '1231.21 ETH',
          'fiatAmount': '112,131.13 THB',
        },
        {
          'type': TransactionType.transferred,
          'time': '10.08 PM',
          'cryptoAmount': '1231.21 ETH',
          'fiatAmount': '112,131.13 THB',
        },
      ],
    },
  ];

  // --- Widget for displaying the Transaction History List ---
  Widget _buildHistoryView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter Bar (from the second provided code block)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundBrandHover, // Replaced explicit Color(0xFF1E1E1E) with AppColors.surfaceSecondary
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FilterOptionChip(label: 'This month', onTap: () {}),
              const SizedBox(width: 4), 
              FilterOptionChip(label: 'All network', onTap: () {}),
            ],
          ),
        ),
        const SizedBox(height: 16), 

        // Transaction List Container (from the second provided code block)
        Container(
          padding: const EdgeInsets.all(12),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF1E1E1E), // Using the explicit color from the design for this specific container
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
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
                      child: TransactionListItem(
                        type: item['type'],
                        time: item['time'],
                        cryptoAmount: item['cryptoAmount'],
                        fiatAmount: item['fiatAmount'],
                        source: item['source'],
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

  // --- Widget for displaying the Transfer Form ---
  Widget _buildTransferView() {
    return Column(
        children: [
          const SizedBox(height: 16),

          // --- Transfer Form Container ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColors.backgroundBrandHover, // Background-Brand-Hover
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // Using SizedBox for spacing
              children: [
                // --- Transferor Section Header ---
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Transferor',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      height: 1.40,
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Spacing after header
                
                DetailedButton(
  
                  text: 'ETH',
                  subText: 'Available Credit',
                  rightText: '0.67 ETH',
                  subRightText: '1,210 THB',
                  iconLeft: const Icon(Icons.star_rounded, color: AppColors.primaryPink, size: 32),
                  iconRight: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textPrimary, size: 24),
                  
                  onTap: () {
                    debugPrint('Select Crypto Tapped (via DetailedButton)');
                  },
                ),
                const SizedBox(height: 16),
                
                // --- Amount Input Field ---
                InputField(
                  labelText: 'Amount',
                  suffixIcon: const Text(
                    "ETH",
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Spacing
                
                // --- Receiver Section Header ---
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Receiver',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      height: 1.40,
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Spacing after header
                
                // --- Address Input Field ---
                InputField(
                  labelText: 'Address',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner_rounded, color: AppColors.textTertiary,),
                    onPressed: () {
                      debugPrint("TODO: Implement QR scan");
                  },),
                ),
              ],
            ),
          ),
          // -------------------------------------------------------------------

          const SizedBox(height: 24), // Spacing before the main action button

          // Next Button (Primary Action)
          const Button(
            label: 'Next',
            type: ButtonType.primary,
            key: ValueKey('Transfer Next'),
            // onPressed: null, // Placeholder for action
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
          // 1. Transaction Title and Transfer/History Control (TOGGLE)
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
              TransferHistoryControl(
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
          _currentTransactionView == SegmentedControlOption.transfer
              ? _buildTransferView()
              : _buildHistoryView(),
        ],
      ),
    );
  }
}