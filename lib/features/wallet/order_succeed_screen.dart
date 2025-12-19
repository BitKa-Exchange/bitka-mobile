import 'dart:math';

import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:bitka/util/widget_saver.dart';
import 'package:flutter/material.dart';

class OrderSucceedScreen extends StatefulWidget {
  final String transferorName;
  final String transferorId;
  final String transferredTitle;
  final String transferredCurrency;
  final double transferredAmount;
  final double valueAmount;
  final String valueCurrency;
  final double feeAmount;
  final String feeCurrency;
  final String transactionId;
  final DateTime datetime;
  final double feeValueAmount;
  final String feeValueCurrency;

  final ({String name, String id})? namedReceiver;
  final ({String address, String platform, String chain})? anonymousReceiver;

  const OrderSucceedScreen({
    super.key,
    required this.transferorName,
    required this.transferredTitle,
    required this.transferredCurrency,
    required this.transferredAmount,
    required this.transferorId,
    this.anonymousReceiver,
    this.namedReceiver,
    required this.valueAmount,
    required this.valueCurrency,
    required this.feeAmount,
    required this.feeCurrency,
    required this.feeValueAmount,
    required this.feeValueCurrency,
    required this.transactionId,
    required this.datetime,
  }) : assert(
         (namedReceiver != null) ^ (anonymousReceiver != null),
         'You must provide exactly one of `namedReceiver` or `anonymousReceiver`. Neither none nor both are allowed.',
       );

  @override
  State<OrderSucceedScreen> createState() => _OrderSucceedScreenState();
}

class _OrderSucceedScreenState extends State<OrderSucceedScreen> {
  static final _subtitleStyle = AppTextStyles.labelLarge.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _detailStyle1 = AppTextStyles.captionMedium.copyWith(
    fontFamily: 'Montserrat',
  );

  static final _detailStyle2 = AppTextStyles.captionBold.copyWith(
    fontFamily: 'Montserrat',
  );

  @override
  Widget build(BuildContext context) {
    late final List<Widget>? named;
    late final List<Widget>? anonymous;

    if (widget.namedReceiver != null) {
      named = [
        DetailedButton.secondary(
          text: widget.namedReceiver!.name,
          subText: widget.namedReceiver!.id,
        ),
      ];
      anonymous = null;
    } else {
      anonymous = [
        DetailedButton.secondary(
          text: widget.anonymousReceiver!.address,
          subText: "Address",
        ),
        const SizedBox(height: 7),
        DetailedButton.secondary(
          text: widget.anonymousReceiver!.platform,
          subText: widget.anonymousReceiver!.chain,
        ),
      ];
      named = null;
    }

    final innerReceipt = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            SizedBox(
              height: 22,
              child: FittedBox(
                child: Text("Transferor", style: _subtitleStyle),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        DetailedButton.secondary(
          borderColor: Colors.transparent,
          text: widget.transferorName,
          subText: widget.transferorId,
        ),
        SizedBox(
          height: 40,
          child: Center(
            child: Transform.rotate(
              angle: 90 * pi / 180,
              child: const Icon(
                size: 15,
                Icons.send,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
        ...?named,
        ...?anonymous,
        const SizedBox(height: 10),
        SizedBox(
          height: 22,
          child: FittedBox(child: Text("Amount", style: _subtitleStyle)),
        ),
        const SizedBox(height: 10),
        DetailedButton.secondary(
          iconLeft: const Icon(
            Icons.star_rounded,
            color: AppColors.primaryPink,
            size: 32,
          ),
          text: widget.transferredCurrency,
          subText: widget.transferredTitle,
          rightText:
              '${widget.transferredAmount.toStringAsFixed(2)} ${widget.transferredCurrency}',
          subRightText: '${widget.valueAmount} ${widget.valueCurrency}',
          borderColor: Colors.transparent,
        ),
        const SizedBox(height: 7),
        DetailedButton.secondary(
          backgroundColor: AppColors.surfaceBorderPrimary,
          text: 'Withdraw Fee',
          rightText:
              '${widget.feeAmount.toStringAsFixed(2)} ${widget.feeCurrency}',
          subRightText:
              '${widget.feeValueAmount.toStringAsFixed(2)} ${widget.feeValueCurrency}',
        ),
        const SizedBox(height: 7),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Transaction ID ", style: _detailStyle1),
              TextSpan(text: widget.transactionId, style: _detailStyle2),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Date ", style: _detailStyle1),
              TextSpan(
                text:
                    '${widget.datetime.year.toString().padLeft(4, '0')}-${widget.datetime.month.toString().padLeft(2, '0')}-${widget.datetime.day.toString().padLeft(2, '0')} ${widget.datetime.hour.toString().padLeft(2, '0')}:${widget.datetime.minute.toString().padLeft(2, '0')}:${widget.datetime.second.toString().padLeft(2, '0')} UTC${switch (widget.datetime.timeZoneOffset.inHours) {
                      var val when val > 0 => '+$val',
                      var val when val <= 0 => '-$val',
                      _ => 'Z',
                    }}',
                style: _detailStyle2,
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: "Order Confirmation", showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: BoxBorder.all(
                  width: 2,
                  color: AppColors.surfaceBorderPrimary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: innerReceipt,
            ),
            Column(
              children: [
                Button(
                  type: .secondary,
                  label: 'Save Picture',
                  onPressed: () async {
                    // show blocking progress indicator while saving
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.textOnBrand,
                        ),
                      ),
                    );

                    final double height = (named == null ? 560 : 490);
                    const double width = 396;
                    const double additional = 20;
                    await WidgetToImageSaver.captureAndSave(
                      targetWidget: Container(
                        height: height + additional,
                        width: width + additional,
                        color: Colors.transparent, // AppColors.background,
                        child: Padding(
                          padding: const EdgeInsets.all(additional),
                          child: Container(
                            // height: height,
                            // width: width,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              border: BoxBorder.all(
                                width: 2,
                                color: AppColors.surfaceBorderPrimary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            child: innerReceipt,
                          ),
                        ),
                      ),
                      targetWidth: width + additional,
                      targetHeight: height + additional,
                    );

                    // dismiss progress
                    // ignore: use_build_context_synchronously
                    if (Navigator.of(context).canPop()) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const SizedBox(height: 10),
                Button(type: .secondary, label: 'Return', onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                }),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
