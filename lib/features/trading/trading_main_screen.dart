import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:bitka/shared/widgets/custom_chip.dart';
import 'package:bitka/shared/widgets/icon_chip.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

enum _ChipSelected { trending, favorite, isNew }

enum _SortSelected { none, valueAscending, valueDescending }

class TradingTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final String currency;
  final double percent;
  final double price;
  final String? priceCurrency;
  final bool favorited;
  final bool isNew;
  final String assetId;
  const TradingTile({
    super.key,
    this.icon = const Placeholder(color: AppColors.backgroundWarning),
    this.title = '',
    this.currency = '',
    this.percent = 0,
    this.price = 0,
    this.priceCurrency,
    this.favorited = false,
    this.isNew = false, required this.assetId,
  });

  static const defaultPriceCurrency = 'THB';

  static final _titleStyle = AppTextStyles.bodyMediumBold.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _subStyle = AppTextStyles.bodyMediumRegular.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _priceStyle = AppTextStyles.bodySmallSemiBold.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _bullishStyle = AppTextStyles.trendBullish.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _bearishStyle = AppTextStyles.trendBearish.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _neutralStyle = AppTextStyles.trendNeutral.copyWith(
    fontFamily: 'Montserrat',
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
  var selectedChip = _ChipSelected.trending;
  var sort = _SortSelected.none;

  @override
  Widget build(BuildContext context) {
    late List<TradingTile> finalList;
    switch (selectedChip) {
      case .trending:
        finalList = List.of(widget.children);
      case .favorite:
        finalList = List.of(widget.children)
            .where((TradingTile element) => element.favorited)
            .toList();
      case .isNew:
        finalList = List.of(widget.children)
            .where((TradingTile element) => element.isNew)
            .toList();
    }
    switch (sort) {
      case .valueAscending:
        finalList.sort((a, b) => a.price < b.price ? -1 : (a.price > b.price ? 1 : 0),);
      case .valueDescending:
        finalList.sort((a, b) => a.price < b.price ? 1 : (a.price > b.price ? -1 : 0),);
      case .none:
        break;
    }

    debugPrint('a');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trade',
        actionsPadding: const EdgeInsets.only(right: 8.0),
        titlePadding: const EdgeInsets.only(left: 8.0),
        actions: [
          IconChip(Icons.access_time)
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
                        onPressed: () =>
                            setState(() => selectedChip = .trending),
                        selected: selectedChip == .trending,
                      ),
                      const SizedBox(width: 8),
                      CustomChip.pinkTint(
                        label: 'Favorited',
                        onPressed: () =>
                            setState(() => selectedChip = .favorite),
                        selected: selectedChip == .favorite,
                      ),
                      const SizedBox(width: 8),
                      CustomChip.pinkTint(
                        label: 'New',
                        onPressed: () => setState(() => selectedChip = .isNew),
                        selected: selectedChip == .isNew,
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
                        onPressed: () {
                          setState(
                            () => sort = switch (sort) {
                              (.valueAscending) => .valueDescending,
                              (.valueDescending) => .none,
                              (.none) => .valueAscending,
                            },
                          );
                        },
                        icon: switch (sort) {
                          (.valueAscending) => Icons.arrow_downward,
                          (.valueDescending) => Icons.arrow_upward,
                          (.none) => null,
                        },
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
