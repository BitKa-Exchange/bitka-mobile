import 'dart:math';

import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/shared/widgets/custom_chip.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

enum _ChipSelected { trending, favorite, isNew }

class TradingTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final String currency;
  final double percent;
  final double price;
  final String? priceCurrency;
  final bool favorited;
  final bool isNew;
  const TradingTile({
    super.key,
    this.icon = const Placeholder(color: AppColors.backgroundWarning),
    this.title = '',
    this.currency = '',
    this.percent = 0,
    this.price = 0,
    this.priceCurrency,
    this.favorited = false,
    this.isNew = false,
  });

  static const defaultPriceCurrency = 'THB';

  static const _titleStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w800,
  );

  static const _subStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
  );

  static const _priceStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );

  static const _bullishStyle = TextStyle(
    color: AppColors.utilityGreen,
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );

  static const _bearishStyle = TextStyle(
    color: AppColors.utilityRed,
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );

  static const _neutralStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    const seperator = SizedBox(width: 10);
    return Container(
      height: 54,
      color: AppColors.surfaceSecondary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(child: AspectRatio(aspectRatio: 1, child: icon)),
                // seperator,
                Text(title, style: _titleStyle),
                seperator,
                Text(currency, style: _subStyle),
              ],
            ),
            Row(
              children: [
                (percent > 0)
                    ? Text(
                        '+${percent.toStringAsFixed(2)}%',
                        style: _bullishStyle,
                      )
                    : (percent < 0
                          ? Text(
                              '${percent.toStringAsFixed(2)}%',
                              style: _bearishStyle,
                            )
                          : Text(
                              '${percent.toStringAsFixed(2)}%',
                              style: _neutralStyle,
                            )),
                seperator,
                Text(
                  '${price.toStringAsFixed(2)} ${priceCurrency ?? defaultPriceCurrency}',
                  style: _priceStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TradingMainScreen extends StatefulWidget {
  final List<TradingTile> children;
  const TradingMainScreen({super.key, this.children = const <TradingTile>[]});

  @override
  State<TradingMainScreen> createState() => _TradingMainScreenState();
}

class _TradingMainScreenState extends State<TradingMainScreen> {
  var selected = _ChipSelected.trending;

  @override
  Widget build(BuildContext context) {
    late List<TradingTile> finalList;
    switch (selected) {
      case .trending:
        finalList = widget.children;
      case .favorite:
        finalList = widget.children
            .where((TradingTile element) => element.favorited)
            .toList();
      case .isNew:
        finalList = widget.children
            .where((TradingTile element) => element.isNew)
            .toList();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trade',
        actionsPadding: const EdgeInsets.only(right: 8.0),
        titlePadding: const EdgeInsets.only(left: 8.0),
        actions: [
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.surfaceBorderPrimary,
                    width: 2,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Icon(Icons.access_time),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomChip.pinkTint(
                        label: 'Trending',
                        onPressed: () => setState(() => selected = .trending),
                        selected: selected == .trending,
                      ),
                      const SizedBox(width: 8),
                      CustomChip.pinkTint(
                        label: 'Favorited',
                        onPressed: () => setState(() => selected = .favorite),
                        selected: selected == .favorite,
                      ),
                      const SizedBox(width: 8),
                      CustomChip.pinkTint(
                        label: 'New',
                        onPressed: () => setState(() => selected = .isNew),
                        selected: selected == .isNew,
                      ),
                    ],
                  ),
                ),
                const Divider(color: AppColors.surfaceBorderPrimary),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomChip.pinkTintOutlined(
                        label: 'Filter',
                        onPressed: () {},
                        icon: Icons.filter_alt_outlined,
                      ),
                      CustomChip.pinkTintOutlined(
                        label: 'Sort by value',
                        onPressed: () {},
                        icon: Icons.arrow_downward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // FIX: Wrap ListView in Expanded to give it bounded height
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 2,
              ),
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                  color: AppColors.surfaceBorderPrimary,
                  height: 2,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return finalList[index];
              },
              itemCount: finalList.length,
            ),
          ),
        ],
      ),
    );
  }
}
