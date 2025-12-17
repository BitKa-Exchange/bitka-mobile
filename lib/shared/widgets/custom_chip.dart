import 'package:bitka/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  static const Color chipBackgroundColor = AppColors.backgroundCardDefault;
  static const Color chipForegroundColor = AppColors.textTertiary;

  factory CustomChip.pinkTint({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    bool selected = false,
  }) {
    return _PinkCustomChip(
      key: key,
      label: label,
      onPressed: onPressed,
      selected: selected,
    );
  }

  factory CustomChip.pinkTintOutlined({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return _PinkOutlinedCustomChip(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: chipBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: chipBackgroundColor, width: 0),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.grey.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: chipForegroundColor,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  icon ?? Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: chipForegroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinkOutlinedCustomChip extends CustomChip {
  const _PinkOutlinedCustomChip({
    super.key,
    required super.label,
    required super.onPressed,
    super.icon,
  });

  static const Color chipBackgroundColor = AppColors.surfaceSecondary;
  static const Color chipForegroundColor = AppColors.textPrimary;
  static const Color chipOutlineColor = AppColors.surfaceStroke;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: chipBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: chipOutlineColor, width: 2),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          splashColor: AppColors.primaryPink.withOpacity(0.2),
          highlightColor: AppColors.primaryPink.withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.fromLTRB(7, 4, (icon == null ? 7 : 4), 4),
            child: Row(
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
                if (icon != null) ...[
                  const SizedBox(width: 4),
                  Icon(icon, size: 18, color: chipForegroundColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinkCustomChip extends CustomChip {
  final bool selected;

  const _PinkCustomChip({
    super.key,
    required super.label,
    required super.onPressed,
    required this.selected,
  });

  static const Color chipBackgroundColor = AppColors.surfaceBorderPrimary;
  static const Color chipForegroundColor = AppColors.surfaceSecondaryContrast;
  static const Color selectedBackgroundColor = AppColors.primaryPink;
  static const Color selectedForegroundColor = AppColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    const radius = 9.0;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: selected ? selectedBackgroundColor : chipBackgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: chipBackgroundColor, width: 0),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radius),
          splashColor: AppColors.primaryPink.withOpacity(0.3),
          highlightColor: AppColors.primaryPink.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              label,
              style: TextStyle(
                color: selected ? selectedForegroundColor : chipForegroundColor,
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
