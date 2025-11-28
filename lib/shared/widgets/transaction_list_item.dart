import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum TransactionType { receive, transferred }

class TransactionListItem extends StatelessWidget {
  final TransactionType type;
  final String time;
  final String cryptoAmount;
  final String fiatAmount;
  final String? source; // Used for "From Somchai Saichom"
  final VoidCallback onTap;

  const TransactionListItem({
    super.key,
    required this.type,
    required this.time,
    required this.cryptoAmount,
    required this.fiatAmount,
    this.source,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReceive = type == TransactionType.receive;
    final Color amountColor = isReceive ? AppColors.utilityGreen : AppColors.utilityRed;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: ShapeDecoration(
          color: AppColors.backgroundCardDefault, // 2C2C2C (Background-Brand-Default)
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              color: AppColors.backgroundCardDefault, // 383838
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            // Row 1: Icon, Type, Time, and Amounts
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Side: Icon, Type, Time
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      const Icon(
                        Icons.star_rounded, // Star icon from the design
                        color: AppColors.primaryPink, // Pink color for the icon
                        size: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isReceive ? 'Receive' : 'Transferred',
                            style: const TextStyle(
                              color: AppColors.textPrimary, // F2F2F2
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              height: 1.29,
                            ),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: AppColors.textTertiary, // B3B3B3
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
                // Right Side: Amounts
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cryptoAmount,
                      style: TextStyle(
                        color: amountColor,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 1.29,
                      ),
                    ),
                    Text(
                      fiatAmount,
                      style: const TextStyle(
                        color: AppColors.textTertiary, // B3B3B3
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
            
            // Row 2: Source/Destination (only shown for Receive in the design)
            if (source != null)
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'From ',
                      style: TextStyle(
                        color: AppColors.textPrimary, // F2F2F2
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                    ),
                    TextSpan(
                      text: source!,
                      style: const TextStyle(
                        color: AppColors.textPrimary, // F2F2F2
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}