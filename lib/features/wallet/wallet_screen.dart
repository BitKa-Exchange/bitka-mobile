import 'package:bitka/shared/widgets/transfer_form_container.dart';
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
    return const Column(
      children: [
        SizedBox(height: 16), // No filters are shown in Transfer view
        
        // Transfer Form Container
        TransferFormContainer(),

        SizedBox(height: 24), // Spacing before the main action button

        // Next Button (Primary Action)
        Button(
          label: 'Next',
          type: ButtonType.primary,
          key: ValueKey("Hi"),
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