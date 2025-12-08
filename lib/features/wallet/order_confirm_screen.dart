import 'dart:math';

import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatefulWidget {
  final String transferorName;
  final String transferorId;

  final ({String name, String id})? namedReceiver;
  final ({
    String address,
    String platform,
    String chain,
    double receivedAmount,
    String receivedCurrency,
    double feeAmount,
    String feeCurrency,
  })?
  anonymousReceiver;

  final String transferredTitle;
  final String transferredCurrency;
  final double transferredAmount;

  final double transferredValue;
  final String valueCurrency;

  const OrderConfirmScreen({
    super.key,
    required this.transferorName,
    required this.transferredTitle,
    required this.transferredCurrency,
    required this.transferredAmount,
    required this.transferredValue,
    required this.valueCurrency,
    required this.transferorId,
    // Make the parameters optional by removing `required`
    this.anonymousReceiver,
    this.namedReceiver,
  }) : assert(
         (namedReceiver != null) ^ (anonymousReceiver != null),
         'You must provide exactly one of `namedReceiver` or `anonymousReceiver`. Neither none nor both are allowed.',
       );

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  static const _subtitleStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
    height: 1.40,
  );

  static const _detailStyle = TextStyle(
    color: AppColors.textTertiary,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.40,
  );

  @override
  Widget build(BuildContext context) {
    late final List<Widget>? named;
    late final List<Widget>? anonymous;

    if (widget.namedReceiver != null) {
      named = [
        DetailedButton(
          text: widget.namedReceiver!.name,
          subText: widget.namedReceiver!.id,
        ),
      ];
      anonymous = null;
    } else {
      anonymous = [
        DetailedButton(
          text: widget.anonymousReceiver!.address,
          subText: "Address",
        ),
        const SizedBox(height: 7),
        DetailedButton(
          text: widget.anonymousReceiver!.platform,
          subText: widget.anonymousReceiver!.chain,
          rightText:
              '${widget.anonymousReceiver!.receivedAmount.toStringAsFixed(2)} ${widget.anonymousReceiver!.receivedCurrency}',
          subRightText:
              '${widget.anonymousReceiver!.feeAmount.toStringAsFixed(2)} ${widget.anonymousReceiver!.feeCurrency}',
        ),
      ];
      named = null;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
          colors: [
            AppColors.backgroundGradient1,
            AppColors.backgroundGradient2,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: "Order Confirmation"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundBrandHover,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 22,
                              child: FittedBox(
                                child: Text(
                                  "Transferor",
                                  style: _subtitleStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        DetailedButton(
                          borderColor: Colors.transparent,
                          text: widget.transferorName,
                          subText: widget.transferorId,
                        ),
                        const SizedBox(height: 7),
                        DetailedButton(
                          iconLeft: const Icon(
                            Icons.star_rounded,
                            color: AppColors.primaryPink,
                            size: 32,
                          ),
                          text: widget.transferredCurrency,
                          subText: widget.transferredTitle,
                          rightText:
                              '${widget.transferredAmount.toStringAsFixed(2)} ${widget.transferredCurrency}',
                          subRightText:
                              '${widget.transferredValue} ${widget.valueCurrency}',
                          borderColor: Colors.transparent,
                        ),
                        SizedBox(
                          height: 40,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    height: 22,
                                    child: FittedBox(
                                      child: Text(
                                        "Receiver",
                                        style: _subtitleStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Transform.rotate(
                                  angle: 90 * pi / 180,
                                  child: const Icon(
                                    size: 15,
                                    Icons.send,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...?named,
                        ...?anonymous,
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Please double-check the recipient\u{2019}s account number. Transfers cannot be reversed once submitted.",
                      style: _detailStyle,
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Button(label: "Confirm Transfer"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        // Using Expanded ensures buttons share the row width properly
                        child: Button(
                          label: "Cancel Order",
                          type: .secondary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Button(
                          label: "Edit Order",
                          type: .secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
