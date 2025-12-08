import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/wallet/order_succeed_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bitka',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: OrderSucceedScreen(
        transferorId: 'T_ID',
        transferorName: 'T_NAME',
        transferredAmount: 1.23,
        transferredCurrency: 'T_CUR',
        transferredTitle: 'T_TITLE',
        valueCurrency: 'V_CUR',
        feeAmount: 4.56,
        feeCurrency: 'F_CUR',
        valueAmount: 7.89,
        feeValueAmount: 10.11,
        feeValueCurrency: 'FV_CUR',
        // anonymousReceiver: (
        //   address: 'Re_Ad',
        //   chain: 'Re_Chain',
        //   platform: 'Re_Plat',
        // ),
        namedReceiver: (
          id: 'Re_Id',
          name: 'Re_Name'
        ),
        transactionId: 'xxxxxxxxxxxxxxxxxxxx',
        datetime: DateTime.now(),
      ),
    );
  }
}
