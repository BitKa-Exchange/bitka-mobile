import 'package:bitka/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IconChip extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  const IconChip(this.icon, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceBorderPrimary, width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}
