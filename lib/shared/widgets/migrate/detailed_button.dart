import 'package:flutter/material.dart';
// Assuming AppColors is imported from your core/theme directory
import 'package:bitka/core/theme/app_colors.dart';

class DetailedButton extends StatelessWidget {
  // Required fields
  final String text; // Main text / Title
  final VoidCallback? onTap;

  // Visual/Styling fields (camelCase)
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  
  // Content fields (all optional and conditionally rendered - camelCase)
  final Widget? iconLeft;
  final Widget? iconRight;
  final String? subText;
  final String? rightText;
  final String? subRightText;
  final String? detailText;

  const DetailedButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.onTap,
    this.iconLeft,
    this.iconRight,
    this.subText,
    this.rightText,
    this.subRightText,
    this.detailText,
  });

  @override
  Widget build(BuildContext context) {
    // Determine button padding based on content (a simplified heuristic)
    final bool hasDetail = detailText != null;
    final EdgeInsets buttonPadding = hasDetail
        ? const EdgeInsets.all(16) // Larger padding if detail text is present
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 14); // Standard padding

    // Determine border radius (defaulting to 16 if no borderColor is provided)
    final BorderRadius buttonRadius = BorderRadius.circular(
      hasDetail ? 16 : 8,
    );

    // --- Top Section Widget (Handles text, subText, rightText, etc.) ---
    final topSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LEFT CONTENT
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconLeft != null) ...[
              iconLeft!,
              const SizedBox(width: 8),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // SUB TEXT
                if (subText != null)
                  Text(
                    subText!,
                    style: TextStyle(
                      color: foregroundColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ],
        ),

        // RIGHT CONTENT
        Row(
          mainAxisSize: MainAxisSize.min,
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
                      color: foregroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // SUB RIGHT TEXT
                  if (subRightText != null)
                    Text(
                      subRightText!,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            // RIGHT ICON
            if (iconRight != null) ...[
              const SizedBox(width: 8),
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
            side: BorderSide(color: borderColor),
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