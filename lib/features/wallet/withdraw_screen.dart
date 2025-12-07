import 'dart:math';

import 'package:bitka/core/theme/app_colors.dart';
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
    fontWeight: .w500,
    fontSize: 16,
    height: 1.40,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Withdraw",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailedDropDown(title: "Nattee115", description: "xxxxxxx"),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundBrandHover,
                  borderRadius: const BorderRadius.all(.circular(16)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20),
                        SizedBox(
                          height: 22,
                          child: FittedBox(
                            child: Text("Transferor", style: _subtitleStyle),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    DetailedButton(
                      iconLeft: Icon(
                        Icons.star_rounded,
                        color: AppColors.primaryPink,
                        size: 32,
                      ),
                      text: 'ETH',
                      subText: "Availble Credit",
                      rightText: '0.67 ETH',
                      subRightText: '1,210 THB',
                      iconRight: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10),
                    InputField(suffixLabel: "ETH", labelText: ''),
                    SizedBox(
                      height: 40,
                      child: Stack(
                        alignment: .centerLeft,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
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
                              child: Icon(
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
                      labelText: 'Adress',
                      suffixIcon: Icon(
                        Icons.book,
                        weight: 20000,
                        color: AppColors.textTertiary,
                      ),
                    ),
                    SizedBox(height: 10),
                    DetailedButton(
                      text: 'BITKUB',
                      subText: 'KUB Chain',
                      rightText: "0.00 ETH",
                      subRightText: 'Withdrawl fee',
                      iconRight: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        SizedBox(
                          height: 22,
                          child: FittedBox(
                            child: Text("Equivalant to", style: _subtitleStyle),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    InputField(labelText: '112,231.31', suffixLabel: "THB"),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          // Constrains the width to the remaining space
                          child: Padding(
                            // Add 15px of padding to the right and left,
                            // which reduces the inner child's width by 30px total.
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
              SizedBox(height: 20),
              Button(label: "Next", onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WithdrawScreen()));
              },),
            ],
          ),
        ),
      ),
    );
  }
}