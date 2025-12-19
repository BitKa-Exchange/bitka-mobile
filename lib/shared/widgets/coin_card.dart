import 'package:bitka/core/theme/app_colors.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';


class CoinCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final double price;
  final double quantity;
  final double percent;
  final String priceCurrency;
  final String quantityCurrency;
  final double height;
  final double? width;
  const CoinCard({
    super.key,
    this.height = 54.0,
    this.width,
    required this.title,
    required this.icon,
    required this.price,
    required this.quantity,
    required this.percent,
    required this.priceCurrency,
    required this.quantityCurrency,
  });

  static const background = AppColors.backgroundCardDefault;
  static final shadow = Color.alphaBlend(
    Color.from(alpha: 0.15, red: 0, green: 0, blue: 0),
    background,
  );

  static const textPrimary = AppColors.textPrimary;
  static const textSecondary = AppColors.textTertiary;
  static const bullish = AppColors.utilityGreen;
  static const bearish = AppColors.utilityRed;
  static const neutral = textSecondary;

  @override
  Widget build(BuildContext context) {
    String fixedPercent = percent.toStringAsFixed(2);
    String textPercent = percent > 0
        ? ('+$fixedPercent%')
        : (percent < 0 ? '$fixedPercent%' : '0.00%');

    final upperFontSize = (height - 20) * 0.5;
    final lowerFontSize = (height - 20) * 0.5 - 2;

    final titleStyle = TextStyle(
      color: textPrimary, // Using color variable
      fontSize: upperFontSize,
      fontWeight: FontWeight.w800,
      height: 1,
    );

    final subtitleStyle = TextStyle(
      color: textSecondary, // Using color variable
      fontSize: lowerFontSize,
      fontWeight: FontWeight.w600,
      height: 1,
    );

    final percentStyle = TextStyle(
      color: percent > 0 ? (bullish) : (percent < 0 ? bearish : neutral),
      fontSize: lowerFontSize,
      fontWeight: FontWeight.w600,
      height: 1,
    );

    return SizedBox(
      key: key,
      height: height,
      width: width,
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: shadow),
              BoxShadow(
                offset: Offset(0, -17),
                color: background,
                spreadRadius: 6,
                blurRadius: 10.4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                children: [
                  AspectRatio(aspectRatio: 1.0, child: ClipOval(child: icon)),
                  SizedBox(width: 7),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(title, style: titleStyle),
                      Text(textPercent, style: percentStyle),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text(
                        "${price.toStringAsFixed(2)} $priceCurrency",
                        style: titleStyle,
                      ),
                      Text(
                        '${quantity.toStringAsFixed(2)} $quantityCurrency',
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
