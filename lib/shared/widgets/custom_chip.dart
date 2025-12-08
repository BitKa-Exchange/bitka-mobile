import 'package:bitka/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  
  const CustomChip({
    super.key,
    required this.label,
    required this.onPressed,
  });

  static const Color chipBackgroundColor = AppColors.backgroundCardDefault; 
  static const Color chipForegroundColor = AppColors.textTertiary;         

  @override
  Widget build(BuildContext context) {
    
    final Widget labelWithIcon = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        Text(
          label,
          style: const TextStyle(
            color: chipForegroundColor,
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 18,
          color: chipForegroundColor,
        ),
      ],
    );

    return ActionChip(
      onPressed: onPressed,
      backgroundColor: chipBackgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: const BorderSide(
        color: chipBackgroundColor, 
        width: 1.0, // A minimal width is used
      ),
      label: labelWithIcon,
    );
  }
}