import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/features/wallet/wallet_screen.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/detailed_dropdown.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';


class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  // tempo
  static const String walletId = 'teryertyrb6456456564565gertg4565nj5867ehr68t6'; 

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
                        subText: "Ethereum",
                        iconRight: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundCardDefault,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: QrImageView(
                            backgroundColor: AppColors.textPrimary,
                            size: 200,
                            data: walletId,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 22,
                            child: FittedBox(
                              child: Text("Address", style: _subtitleStyle),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      InputField(
                        labelText: walletId,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.copy),
                            color: AppColors.textTertiary,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: walletId));
                            },
                          )
                      ),
                      const SizedBox(height: 7),

                    ],
                  ),
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}