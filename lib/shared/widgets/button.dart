// lib/shared/widgets/button.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum ButtonType { 
  primary, // Pink fill
  ghost,   // Dark background fill 
  outline, // Transparent fill with border
}

class Button extends StatelessWidget { 
  final String text;
  final ButtonType type;
  final bool isDisabled; // Controls disabled state
  final VoidCallback? onPressed; 

  const Button({
    super.key,
    required this.text,
    this.type = ButtonType.primary,
    this.isDisabled = false, 
    this.onPressed,
  });

  // Helper method to determine styling based on state and type
  Color _getBackgroundColor() {
    // If the button is explicitly disabled, use the disabled color.
    if (isDisabled) {
      return AppColors.backgroundCardDefault; 
    }

    // If the button is NOT explicitly disabled, apply color based on type.
    switch (type) {
      case ButtonType.primary:
        return AppColors.primaryPink; // This is the bright pink color
      case ButtonType.ghost:
        return AppColors.backgroundCardDefault; 
      case ButtonType.outline:
        return Colors.transparent; 
    }
  }

  // Helper method to determine text color
  Color _getTextColor() {
    if (isDisabled) {
      return AppColors.textSecondary; // Grey text for disabled state
    }
    return AppColors.textOnBrand; // White text for active states
  }

  // Helper method to determine border color
  Color _getBorderColor() {
    // Note: Border color logic is identical for both enabled/disabled states here
    return AppColors.surfaceBorderPrimary;
  }

  @override
  Widget build(BuildContext context) {
    // --- FIX: Ensure a function is provided if the button should be enabled. ---
    // The finalOnPressed should be null only if isDisabled is explicitly true.
    // However, if onPressed is null, the ElevatedButton will force the disabled look.
    // If you want the button to look active but not do anything yet, use a dummy function:
    final VoidCallback? finalOnPressed = isDisabled 
        ? null 
        : onPressed ?? () { /* Placeholder if onPressed is null, preventing the disabled look */ }; 
    
    // Note: The logic inside ElevatedButton handles the 'visual' disabled state 
    // when finalOnPressed is null, but we need to pass our custom colors:

    final Color effectiveBackgroundColor = _getBackgroundColor();
    final Color effectiveTextColor = _getTextColor();
    final Color effectiveBorderColor = _getBorderColor();

    return Container(
      width: double.infinity,
      height: 57,
      child: ElevatedButton(
        // Passes null only if isDisabled is true, or if onPressed is null AND we didn't add the fix.
        // With the fix above, it's null only if isDisabled is true.
        onPressed: finalOnPressed, 
        style: ElevatedButton.styleFrom(
          // Use fixed colors for active state, and rely on Flutter's theme for disabled styling
          // (which should pull backgroundCardDefault if finalOnPressed is null)
          
          // Background/Surface color: 
          // Use effectiveBackgroundColor for the primary color when enabled.
          backgroundColor: effectiveBackgroundColor,
          
          // Text color: 
          foregroundColor: effectiveTextColor, 
          
          elevation: 0, 
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              width: 1,
              color: effectiveBorderColor,
            ),
          ),
          textStyle: TextStyle(
            color: effectiveTextColor, // This applies the color defined in textStyle
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
            height: 1.40,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}