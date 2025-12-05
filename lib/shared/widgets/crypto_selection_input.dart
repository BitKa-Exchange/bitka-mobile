import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CryptoSelectionInput extends StatelessWidget {
  final String cryptoCode; // e.g., 'ETH'
  final String availableCredit; // e.g., 'Available Credit'
  final String cryptoValue; // e.g., '0.67 ETH'
  final String fiatValue; // e.g., '1,210 THB'
  final VoidCallback onTap;

  const CryptoSelectionInput({
    super.key,
    required this.cryptoCode,
    required this.availableCredit,
    required this.cryptoValue,
    required this.fiatValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Background-Brand-Default (2C2C2C) with Border-Default-tertiary (383838)
    const Color inputBackgroundColor = Color(0xFF2C2C2C);
    const Color inputBorderColor = Color(0xFF383838);
    const Color primaryTextColor = Color(0xFFF2F2F2);
    const Color tertiaryTextColor = Color(0xFFB3B3B3);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: ShapeDecoration(
          color: inputBackgroundColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              color: inputBorderColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Section: Icon, Crypto Code, Available Credit
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_rounded, // Icon used in the design
                    color: AppColors.primaryPink,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cryptoCode,
                        style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: 17,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 1.29,
                        ),
                      ),
                      Text(
                        availableCredit,
                        style: const TextStyle(
                          color: tertiaryTextColor,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                          height: 1.83,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Right Section: Values and Dropdown Icon
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cryptoValue,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 1.29,
                  ),
                ),
                Text(
                  fiatValue,
                  style: const TextStyle(
                    color: tertiaryTextColor,
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    height: 1.83,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryTextColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}