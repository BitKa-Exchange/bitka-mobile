import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:bitka/shared/widgets/binary_chip.dart';
import 'package:bitka/shared/widgets/custom_chip.dart';
import 'package:bitka/shared/widgets/icon_chip.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

class TradingAssetScreen extends StatefulWidget {
  const TradingAssetScreen({super.key});

  @override
  State<TradingAssetScreen> createState() => _TradingAssetScreenState();
}

class _TradingAssetScreenState extends State<TradingAssetScreen> {
  static final subTextStyle = AppTextStyles.bodySmallBold.copyWith(
    fontWeight: FontWeight.w700,
  );

  static Widget changeWidget(double percent) {
    late Color color;
    late IconData icon;
    late String text;

    if (percent > 0) {
      color = AppColors.utilityGreen;
      icon = Icons.trending_up_rounded;
      text = '${(percent * 100).ceil()}%';
    } else if (percent < 0) {
      color = AppColors.utilityRed;
      icon = Icons.trending_down;
      text = '${(percent * 100).ceil()}%';
    } else {
      color = AppColors.utilityGreen;
      icon = Icons.trending_flat_rounded;
      text = '${(percent * 100).ceil()}%';
    }

    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 4),
        Text(text, style: subTextStyle.copyWith(color: color)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = 8.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundGradient1,
      appBar: CustomAppBar(
        title: 'Trade',
        actionsPadding: const EdgeInsets.only(right: padding),
        titlePadding: const EdgeInsets.only(left: padding),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11.0),
            child: AspectRatio(
              aspectRatio: 160 / 34,
              child: BinaryPill(leftText: 'Limited', rightText: 'Marktet'),
            ),
          ),
          IconChip(
            Icons.access_time,
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TradingAssetScreen();
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 3),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CustomChip.pinkTintOutlined(
                  label: 'This week',
                  icon: Icons.keyboard_arrow_down_rounded,
                  onPressed: () {},
                ),
                Column(
                  crossAxisAlignment: .end,
                  children: [
                    CustomChip.surfacePrimary(
                      label: 'Ethereum',
                      icon: Icons.keyboard_arrow_down_rounded,
                      onPressed: () {},
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        changeWidget(0.32),
                        SizedBox(width: 4),
                        Text(
                          '${48912730.toStringAsFixed(2)} THB',
                          style: subTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // **Graph**
          Stack(
            children: [
              Container(height: 200, color: Colors.amber,),
              Positioned(
                top: 15,
                left: 20,
                child: SizedBox.square(
                  dimension: 35,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primaryPink,
                      borderRadius: .all(.circular(10)),
                    ),
                    child: Padding(
                      padding: .all(2),
                      child: Icon(
                        Icons.open_in_full_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(horizontal: padding * 3), child: Column(children: [
            BinaryPill(leftText: 'Buy', rightText: 'Sells', height: 40,)
          ],)),
        ],
      ),
    );
  }
}
