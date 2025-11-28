import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AmountInputField extends StatelessWidget {
  final String hintText;
  final String suffixLabel; // e.g., 'ETH'
  final bool hasQRScan;
  final TextEditingController? controller;

  const AmountInputField({
    super.key,
    required this.hintText,
    required this.suffixLabel,
    this.hasQRScan = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // The design uses a Text widget for the label, but for real input, 
    // we use a TextFormField styled to match the container.

    // Background-Brand-Default (2C2C2C) with Border-Default-tertiary (383838)
    const Color inputBackgroundColor = Color(0xFF2C2C2C);
    const Color inputBorderColor = Color(0xFF383838);
    const Color hintColor = Color(0xFF757575); // Text-Brand-Tertiary (used for hints/labels)
    const Color labelColor = Color(0xFF757575); // Text-Brand-Tertiary (used for ETH label)
    const Color primaryTextColor = Color(0xFFF2F2F2); // For actual typed text

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          // Matches the BoxShadow in the original code
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: primaryTextColor,
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          // Padding to match the design's inner padding (16 horizontal, 12 vertical)
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: hintColor,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
          fillColor: inputBackgroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: inputBorderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: inputBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // Use Brand Primary for focus state
            borderSide: const BorderSide(
              width: 1.50,
              color: AppColors.primaryPink, 
            ),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 50, maxWidth: 50),
          suffixIcon: hasQRScan
              ? IconButton(
                  icon: const Icon(Icons.qr_code_scanner_rounded, color: hintColor),
                  onPressed: () {
                    // Logic for scanning QR code
                    debugPrint('QR Code scan activated');
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    suffixLabel,
                    style: const TextStyle(
                      color: labelColor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}