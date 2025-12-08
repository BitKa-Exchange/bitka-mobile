import 'dart:math';

import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/features/wallet/wallet_screen.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/detailed_dropdown.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';


class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

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
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.40,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
          colors: [AppColors.backgroundGradient1, AppColors.backgroundGradient2],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: "Withdraw"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailedDropDown(title: "Nattee115", description: "xxxxxxx"),
                const SizedBox(height: 20),
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
                              child: Text("Transferor", style: _subtitleStyle),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      DetailedButton(
                        iconLeft: const Icon(
                          Icons.star_rounded,
                          color: AppColors.primaryPink,
                          size: 32,
                        ),
                        text: 'ETH',
                        subText: "Available Credit",
                        rightText: '0.67 ETH',
                        subRightText: '1,210 THB',
                        iconRight: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InputField(suffixLabel: "ETH", labelText: 'Amount'),
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
                      InputField(
                        labelText: 'Address',
                        suffixIcon: const Icon(
                          Icons.book,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DetailedButton(
                        text: 'BITKUB',
                        subText: 'KUB Chain',
                        rightText: "0.00 ETH",
                        subRightText: 'Withdrawal fee',
                        iconRight: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 22,
                            child: FittedBox(
                              child: Text("Equivalent to", style: _subtitleStyle),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      InputField(labelText: '112,231.31', suffixLabel: "THB"),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'By global market at 11:03:24 UTC+7',
                                  style: _detailStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  label: "Next",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AppShellScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}