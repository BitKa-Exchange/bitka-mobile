import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/shared/widgets/account_header_card.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/option_card.dart'; // For the settings menu rows

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0).copyWith(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),


          const Text(
            'Account Setting',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 34,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),

          TransactionHeaderCard(
            name: 'Nattan Niparnee',
            accountId: '123-XXXX-1234',
            onTap: () {
              // Navigate to Account tab
              AppShellScreen.navigateToIndex(context, 3);
            },
          ),
          const SizedBox(height: 20),


          OptionCard(
            title: 'Personal Information',
            leadingIcon: Icons.settings_rounded,
            iconColor: AppColors.surfaceSecondaryContrast,
            onTap: () {
              debugPrint('Personal Information tapped!');
            },
          ),
          const SizedBox(height: 8),

          OptionCard(
            title: 'Email Password',
            leadingIcon: Icons.info_outline_rounded,
            iconColor: AppColors.surfaceSecondaryContrast,
            onTap: () {
              debugPrint('Email Password tapped!');
            },
          ),
          const SizedBox(height: 8),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}