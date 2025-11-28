import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DetailCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String detail;
  final String body;
  final String subBody;
  final String multiLineDetail;

  const DetailCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.detail,
    required this.body,
    required this.subBody,
    required this.multiLineDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: ShapeDecoration(
        color: AppColors.surfacePrimary, // Using the color variable
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Top Row (Same as CardItem) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Side
              Expanded(
                child: Row(
                  children: [
                    Icon(iconData, color: AppColors.primaryPink, size: 20),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 17, fontWeight: FontWeight.w700, fontFamily: 'Montserrat', height: 1.29)),
                        Text(detail, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'Montserrat', height: 1.83)),
                      ],
                    ),
                  ],
                ),
              ),
              // Right Side
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(body, style: const TextStyle(color: AppColors.textPrimary, fontSize: 17, fontWeight: FontWeight.w700, fontFamily: 'Montserrat', height: 1.29)),
                  Text(subBody, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'Montserrat', height: 1.83)),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 8), // Replaces 'spacing: 8' between sections

          // --- Bottom Multi-line Detail ---
          Text(
            multiLineDetail,
            style: const TextStyle(
              color: AppColors.textPrimary, // Using color variable
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
        ],
      ),
    );
  }
}