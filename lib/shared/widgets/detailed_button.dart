import 'package:flutter/material.dart';
import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';

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
                  style: AppTextStyles.bodyLargeBold.copyWith(
                    fontFamily: 'Montserrat',
                    color: foregroundColor,
                  ),
                ),
                // SUB TEXT (Available Credit)
                if (subText != null)
                  Text(
                    subText!,
                    style: AppTextStyles.captionSmallBold.copyWith(
                      fontFamily: 'Montserrat',
                      color: hasDetail ? foregroundColor : AppColors.textTertiary,
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
                    style: AppTextStyles.bodyLargeBold.copyWith(
                      fontFamily: 'Montserrat',
                      color: rightTextColor ?? foregroundColor,
                    ),
                  ),
                  // SUB RIGHT TEXT
                  if (subRightText != null)
                    Text(
                      subRightText!,
                      style: AppTextStyles.captionSmallBold.copyWith(
                        fontFamily: 'Montserrat',
                        color: rightTextColor ?? AppColors.textSecondary,
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
                style: AppTextStyles.bodySmallSemiBold.copyWith(
                  color: foregroundColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}