import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/amount_input_field.dart';
import '../../../shared/widgets/crypto_selection_input.dart';

class TransferFormContainer extends StatelessWidget {
  const TransferFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const Color tertiaryTextColor = AppColors.textTertiary; // Text-Default-Tertiary

    return Container(
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
        spacing: 16,
        children: [
          // --- Transferor Section ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Transferor',
              style: TextStyle(
                color: tertiaryTextColor,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                height: 1.40,
              ),
            ),
          ),
          
          CryptoSelectionInput(
            cryptoCode: 'ETH',
            availableCredit: 'Available Credit',
            cryptoValue: '0.67 ETH',
            fiatValue: '1,210 THB',
            onTap: () {
              debugPrint('Select Crypto Tapped');
            },
          ),
          
          AmountInputField(
            hintText: 'Amount',
            suffixLabel: 'ETH',
            hasQRScan: false,
            controller: TextEditingController(),
          ),
          
          // --- Receiver Section ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Receiver',
              style: TextStyle(
                color: tertiaryTextColor,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                height: 1.40,
              ),
            ),
          ),
          
          AmountInputField(
            hintText: 'Address',
            suffixLabel: '', // Suffix is handled by hasQRScan
            hasQRScan: true,
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}