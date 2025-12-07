
// TODO

import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';

Widget buildTransferView() {
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