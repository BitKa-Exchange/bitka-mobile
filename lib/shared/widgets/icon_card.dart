import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color labelColor;
  
  // Optional: Add a property to show if the card is currently selected/active
  final bool isActive; 

  const IconCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor = AppColors.surfaceBorderPrimary, // 0xFF48343D
    this.iconColor = AppColors.textPrimary, // 0xFFF5F5F5
    this.labelColor = AppColors.textPrimary, // 0xFFF5F5F5
    this.isActive = false, // Default is false
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on active state
    final Color activeBackgroundColor = AppColors.primaryPink; 
    // If used in the Bottom Nav Bar, the active background color will be pink
    final Color finalBackgroundColor = isActive ? activeBackgroundColor : backgroundColor;
    const Color foregroundColor = AppColors.textOnBrand;
    
    // IconColor and LabelColor logic adjusted to ensure they are the foregroundColor (white/textOnBrand) when active
    final Color finalIconColor = isActive ? foregroundColor : iconColor;
    final Color finalLabelColor = isActive ? foregroundColor : labelColor;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 81.50,
        height: 69,
        padding: const EdgeInsets.symmetric(vertical: 10), 
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: finalBackgroundColor,
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
              color: finalIconColor, 
              size: 24
            ),
            
            const SizedBox(height: 4),
            
            // --- Label ---
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: finalLabelColor,
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