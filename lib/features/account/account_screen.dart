import 'package:bitka/shared/widgets/migrate/detailed_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import '../../../core/theme/app_colors.dart';

import '../../../shared/widgets/option_card.dart'; // For the settings menu rows

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0).copyWith(bottom: 120), // Add bottom padding for the persistent nav bar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // Title: Account
          const Text(
            'Account',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 34,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),

          // 1. User Info Header (Reusable CustomDropdownHeader)
          DetailedDropDown(
            title: 'Nattan Niparnee',
            description: '123-XXXX-1234',
          ),
          const SizedBox(height: 20),

          // 2. Alert/Profile Completion Card (OptionCard with Yellow Styling)
          OptionCard(
            title: 'Complete your profile',
            leadingIcon: Icons.notifications_active_rounded,
            iconColor: AppColors.backgroundWarning, // Use a yellow/gold color for alert
            backgroundColor: AppColors.backgroundCardDefault, // Assuming dark background
            borderColor: AppColors.backgroundWarning, // Yellow border for emphasis
            onTap: () {
              debugPrint('Complete profile tapped!');
            },
          ),
          const SizedBox(height: 20),

          // 3. Settings Menu (Reusable OptionCard)
          
          // Account Setting
          OptionCard(
            title: 'Account Setting',
            leadingIcon: Icons.settings_rounded,
            iconColor: AppColors.surfaceSecondaryContrast,
            onTap: () {
              debugPrint('Account Setting pressed!');
              AppShellScreen.navigateToIndex(context, 4);
            },
          ),
          const SizedBox(height: 8),

          // Application Info
          OptionCard(
            title: 'Application Info',
            leadingIcon: Icons.info_outline_rounded,
            iconColor: AppColors.surfaceSecondaryContrast,
            onTap: () {
              debugPrint('Application Info tapped!');
            },
          ),
          const SizedBox(height: 8),

          // Customer Services
          OptionCard(
            title: 'Customer Services',
            leadingIcon: Icons.phone_in_talk_rounded,
            iconColor: AppColors.surfaceSecondaryContrast,
            onTap: () {
              debugPrint('Customer Services tapped!');
            },
          ),
          
          // Add more space at the bottom if needed
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}