import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:bitka/features/account/profile_screen.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/detailed_dropdown.dart';
import 'package:flutter/material.dart';

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


          Text(
            'Account Setting',
            style: AppTextStyles.displayLarge.copyWith(
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 20),

          DetailedDropDown(
            title: 'Nattan Niparnee',
            description: '123-XXXX-1234',
          ),
          const SizedBox(height: 20),


          DetailedButton(
            text: 'Profile',
            iconLeft: const Icon(
              Icons.settings_rounded,
              color: AppColors.surfaceSecondaryContrast,
            ),
            iconRight: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textTertiary,
              size: 16,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            }
          ),
          const SizedBox(height: 8),


          DetailedButton(
            text: 'Email Password',
            iconLeft: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.surfaceSecondaryContrast,
            ),
            iconRight: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textTertiary,
              size: 16,
            ),
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