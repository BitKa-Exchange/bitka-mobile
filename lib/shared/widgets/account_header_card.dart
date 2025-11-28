import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TransactionHeaderCard extends StatelessWidget {
  final String name;
  final String accountId;
  final VoidCallback onTap;

  const TransactionHeaderCard({
    super.key,
    required this.name,
    required this.accountId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: ShapeDecoration(
          color: AppColors.primaryPink, // F834A0 (Brand-Primary)
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              color: AppColors.accentSecondary, // FF85B9 (Brand-Secondary)
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textOnBrand, // F2F2F2
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 1.29,
                  ),
                ),
                Text(
                  accountId,
                  style: const TextStyle(
                    color: AppColors.textOnBrand, // F2F2F2
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    height: 1.83,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textOnBrand, // F2F2F2
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}