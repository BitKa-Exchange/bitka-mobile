import 'package:flutter/material.dart';
// Assuming AppColors is imported from your core/theme directory
import 'package:bitka/core/theme/app_colors.dart';

class DetailedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  final Color backgroundColor;
  final Color foregroundColor;
  final Color foregroundSecondaryColor;
  final Color borderColor;
  
  final Widget? iconLeft;
  final Widget? iconRight;
  final String? subText;
  final String? rightText;
  final Color? rightTextColor;
  final String? subRightText;
  final String? detailText;

  const DetailedButton({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.backgroundCardDefault, 
    this.foregroundColor = AppColors.textPrimary,
    this.foregroundSecondaryColor = AppColors.textTertiary,
    this.borderColor = AppColors.borderDefaultTertiary,
    this.onTap,
    this.iconLeft,
    this.iconRight,
    this.subText,
    this.rightText,
    this.rightTextColor,
    this.subRightText,
    this.detailText,
  });

  const DetailedButton.secondary({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.surfaceSecondary, 
    this.foregroundColor = AppColors.textPrimary,
    this.foregroundSecondaryColor = AppColors.textTertiary,
    this.borderColor = Colors.transparent,
    this.onTap,
    this.iconLeft,
    this.iconRight,
    this.subText,
    this.rightText,
    this.rightTextColor,
    this.subRightText,
    this.detailText,
  });
  
  // Static final properties for consistency
  static const double buttonBorderWidth = 2.0; // Use 2.0 width from the old input field
  static const double buttonBorderRadius = 8.0; // Use 8.0 radius from the old input field

  @override
  Widget build(BuildContext context) {
    final bool hasDetail = detailText != null;
    final EdgeInsets buttonPadding = hasDetail
        ? const EdgeInsets.all(16)
        : const EdgeInsets.symmetric(horizontal: 18, vertical: 10);

    final BorderRadius buttonRadius = BorderRadius.circular(
      hasDetail ? 16 : buttonBorderRadius, 
    );

    final topSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LEFT CONTENT
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconLeft != null) ...[
              iconLeft!,
              const SizedBox(width: 12),
            ],
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MAIN TEXT
                Text(
                  text,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // SUB TEXT (Available Credit)
                if (subText != null)
                  Text(
                    subText!,
                    style: TextStyle(
                      color: hasDetail ? foregroundColor : AppColors.textTertiary,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
              ],
            ),
          ],
        ),

        // RIGHT CONTENT
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (rightText != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // RIGHT TEXT
                  Text(
                    rightText!,
                    style: TextStyle(
                      color: rightTextColor ?? foregroundColor,
                      fontSize: 17, // Adjusted font size
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800, // Adjusted font weight
                    ),
                  ),
                  // SUB RIGHT TEXT
                  if (subRightText != null)
                    Text(
                      subRightText!,
                      style: TextStyle(
                        color: rightTextColor ?? AppColors.textSecondary, // Use AppColors.textTertiary for subtext in the min/default view
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                ],
              ),
            // RIGHT ICON (Dropdown Arrow)
            if (iconRight != null) ...[
              const SizedBox(width: 10), // Adjusted spacing
              iconRight!,
            ],
          ],
        ),
      ],
    );
    // -------------------------------------------------------------------

    // --- Main Widget Assembly ---
    return InkWell(
      onTap: onTap,
      borderRadius: buttonRadius,
      child: Container(
        width: double.infinity,
        padding: buttonPadding,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: buttonRadius,
            side: BorderSide(
              color: borderColor,
              width: buttonBorderWidth, // Using 2.0 width
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Always render the top section (as 'text' is required)
            topSection,

            // CONDITIONAL DETAIL SECTION
            if (detailText != null) ...[
              const SizedBox(height: 12),
              // Divider Line (uses foregroundColor)
              Container(height: 1.5, color: foregroundColor), 
              const SizedBox(height: 12),
              
              // Detail Text
              Text(
                detailText!,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}