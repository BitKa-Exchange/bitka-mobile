import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const IconCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor = AppColors.surfaceBorderPrimary,
    this.iconColor = AppColors.textOnBrand,
    this.textColor = AppColors.textOnBrand,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 81.50,
        height: 69,
        padding: const EdgeInsets.symmetric(vertical: 10), 
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Icon ---
            Icon(
              icon, 
              color: iconColor, 
              size: 24
            ),
            
            const SizedBox(height: 4),
            
            // --- Label ---
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}