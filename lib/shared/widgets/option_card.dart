// lib/shared/widgets/option_card.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart'; 

class OptionCard extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;
  final Color iconColor;
  
  // Assuming Background-Brand-Default is AppColors.backgroundCardDefault (0xFF2C2C2C)
  // Assuming Border-Default-tertiary (0xFF383838) is not explicitly mapped, or is close to a border color.
  final Color backgroundColor;
  final Color borderColor;

  const OptionCard({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.iconColor = AppColors.primaryPink, // Use the Brand color for the icon, as seen in the design
    this.backgroundColor = AppColors.backgroundCardDefault, // Assuming 2C2C2C
    this.borderColor = const Color(0xFF383838), // Using the explicit tertiary border color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        // Retaining fixed width if necessary, otherwise use double.infinity
        // Using `double.infinity` for width to adapt to screen size
        width: double.infinity, 
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween to separate leading content and trailing arrow
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Leading Icon and Text
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // Spacing 12 between icon and text
                children: [
                  // Icon Container
                  Container(
                    width: 20, 
                    height: 20, 
                    child: Icon(
                      leadingIcon,
                      size: 20,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title Text
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary, // Assuming 0xFFF2F2F2 is textPrimary
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 1.29,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 2. Trailing Arrow Icon (or placeholder based on your structure)
            // Using a simple forward arrow icon (Icons.arrow_forward_ios) for functionality
            const SizedBox(width: 6), // Spacing between text content and arrow
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16, // Smaller size for the arrow
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}