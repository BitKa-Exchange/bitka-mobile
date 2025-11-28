import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AgreementField extends StatelessWidget {
  final String agreementText;
  final bool isChecked;
  final ValueChanged<bool?> onChecked;
  final VoidCallback onLinkTap;
  final String linkText;

  const AgreementField({
    super.key,
    required this.agreementText,
    required this.isChecked,
    required this.onChecked,
    required this.onLinkTap,
    this.linkText = 'read agreement',
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      // Removed fixed width: 360 for responsiveness
      width: double.infinity, 
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Checkbox and Agreement Text ---
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Custom Checkbox or standard Flutter Checkbox
              InkWell(
                onTap: () => onChecked(!isChecked),
                child: Container(
                  width: 16,
                  height: 16,
                  // Using the custom styling provided in the snippet
                  decoration: BoxDecoration(
                    color: AppColors.textOnBrand,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      width: 1,
                      color: AppColors.textTertiary, // Border-Brand-Tertiary
                    ),
                  ),
                  child: Center(
                    child: isChecked
                        ? const Icon(Icons.check, size: 12, color: AppColors.primaryPink) 
                        : null,
                  ),
                ),
              ),

              const SizedBox(width: 12), // Spacing: 12

              // 2. Agreement Text
              Flexible(
                child: Text(
                  agreementText,
                  style: const TextStyle(
                    color: AppColors.textPrimary, // Text-Neutral-On-Neutral
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                  ),
                ),
              ),
            ],
          ),

          // --- Read Agreement Link (aligned below the text) ---
          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 4.0), // Align with text body
            child: GestureDetector(
              onTap: onLinkTap,
              child: Text(
                linkText,
                style: const TextStyle(
                  color: AppColors.primaryPink, // The bright pink color
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                  decoration: TextDecoration.underline, // Optional: for link clarity
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}