import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:bitka/shared/widgets/binary_pill.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/custom_chip.dart';
import 'package:bitka/shared/widgets/icon_chip.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

enum _OrderType { limited, market }

enum _OrderSide { buy, sell }

class TradingAssetScreen extends StatefulWidget {
  final String assetId;
  const TradingAssetScreen({super.key, required this.assetId});

  @override
  State<TradingAssetScreen> createState() => _TradingAssetScreenState();
}

class _TradingAssetScreenState extends State<TradingAssetScreen> {
  static final subTextStyle = AppTextStyles.bodySmallBold.copyWith(
    fontWeight: FontWeight.w700,
  );

  static Widget percentWidget(double percent) {
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

  _OrderType _type = .limited;
  _OrderSide _side = .buy;

  @override
  Widget build(BuildContext context) {
    const padding = 8.0;
    const separator = SizedBox(height: 10);
    const separator2 = SizedBox(height: 5);

    late final List<Widget> inputs;

    switch (_type) {
      case .limited:
        switch (_side) {
          case .buy:
            inputs = [
              Text("Price per unit", style: AppTextStyles.bodyMediumBold),
              separator2,
              InputField.pink(suffixLabel: "THB"),
              separator,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Buy amount", style: AppTextStyles.bodyMediumBold),
                  Text(
                    "Balance 4,232,093,473 THB",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
              separator2,
              InputField.pink(suffixLabel: "THB"),
              separator,
              Text("Coin amount", style: AppTextStyles.bodyMediumBold),
              separator2,
              InputField.pink(suffixLabel: "ETH"),
              separator,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Trading Fee 4.30%",
                    style: AppTextStyles.bodyMediumSemiBold,
                  ),
                  Text(
                    "4,232,093,473 THB",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
            ];
          case .sell:
            inputs = [
              Text("Price per unit", style: AppTextStyles.bodyMediumBold),
              separator2,
              InputField.pink(suffixLabel: "THB"),
              separator,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Sell amount", style: AppTextStyles.bodyMediumBold),
                  Text(
                    "Balance 4,232,093,473 ETH",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
              separator2,
              InputField.pink(suffixLabel: "ETH"),
              separator,
              Text("Equivalent to", style: AppTextStyles.bodyMediumBold),
              separator2,
              InputField.pink(suffixLabel: "THB"),
              separator,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Trading Fee 4.30%",
                    style: AppTextStyles.bodyMediumSemiBold,
                  ),
                  Text(
                    "4,232,093,473 THB",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
            ];
        }
      case .market:
        switch (_side) {
          case .buy:
            inputs = [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Buy amount", style: AppTextStyles.bodyMediumBold),
                  Text(
                    "Balance 4,232,093,473 THB",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
              separator2,
              InputField.pink(suffixLabel: "THB"),
              separator,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Trading Fee 4.30%",
                    style: AppTextStyles.bodyMediumSemiBold,
                  ),
                  Text(
                    "4,232,093,473 THB",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
            ];
          case .sell:
          inputs = [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Sell amount", style: AppTextStyles.bodyMediumBold),
                  Text(
                    "Balance 4,232,093,473 ETH",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
              separator2,
              InputField.pink(suffixLabel: "ETH"),
              separator,
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Trading Fee 4.30%",
                    style: AppTextStyles.bodyMediumSemiBold,
                  ),
                  Text(
                    "4,232,093,473 THB",
                    style: AppTextStyles.bodyMediumSemiBoldSquished,
                  ),
                ],
              ),
            ];
          
        }
    }

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
              child: BinaryPill(
                leftText: 'Limited',
                rightText: 'Marktet',
                onPressed: (leftSelected) {
                  if (leftSelected && _type != .limited) {
                    setState(() => _type = .limited);
                  } else if (!leftSelected && _type != .market) {
                    setState(() => _type = .market);
                  }
                },
              ),
            ),
          ),
          IconChip(
            Icons.access_time,
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TradingAssetScreen(assetId: 'asdsa');
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
                        percentWidget(0.32),
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
          separator,
          // **Graph**
          Stack(
            children: [
              Container(height: 200, color: Colors.amber),
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
          separator,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding * 3),
              child: Column(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      BinaryPill(
                        leftText: 'Buy',
                        rightText: 'Sells',
                        height: 40,
                        onPressed: (leftSelected) {
                          if (leftSelected && _side == .sell) {
                            setState(() => _side = .buy);
                          } else if (!leftSelected && _side == .buy) {
                            setState(() => _side = .sell);
                          }
                        },
                      ),
                      separator,
                      ...inputs,
                    ],
                  ),
                  Column(
                    children: [
                      Button(label: "Place Order"),
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom > 0
                            ? MediaQuery.of(context).viewPadding.bottom
                            : padding * 3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
