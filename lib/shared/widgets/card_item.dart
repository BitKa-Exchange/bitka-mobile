import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CardItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String detail;
  final String body;
  final String subBody;

  const CardItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.detail,
    required this.body,
    required this.subBody,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: ShapeDecoration(
        color: AppColors.surfacePrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween for left/right alignment
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Left Side: Icon and Text ---
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon placeholder (replaces Container/Stack)
                Icon(iconData, color: AppColors.primaryPink, size: 20),
                const SizedBox(width: 12), // Replaces 'spacing: 12'
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary, // Using color variable
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 1.29,
                      ),
                    ),
                    Text(
                      detail,
                      style: const TextStyle(
                        color: AppColors.textSecondary, // Using color variable
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        height: 1.83,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // --- Right Side: Body and Sub-body ---
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                body,
                style: const TextStyle(
                  color: AppColors.textPrimary, // Using color variable
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  height: 1.29,
                ),
              ),
              Text(
                subBody,
                style: const TextStyle(
                  color: AppColors.textSecondary, // Using color variable
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  height: 1.83,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}