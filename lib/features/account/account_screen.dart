import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/account/profile_setup_screen.dart';
import 'package:bitka/features/auth/login_screen.dart';
import 'package:bitka/providers/auth_provider.dart';
import 'package:bitka/shared/widgets/detailed_button.dart';
import 'package:bitka/shared/widgets/detailed_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:provider/provider.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

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


          DetailedDropDown(
            title: 'Nattan Niparnee',
            description: '123-XXXX-1234',
          ),
          const SizedBox(height: 20),


          DetailedButton(
            text: 'Complete your profile',
            subText: 'To allow the access to all features',
            iconLeft: const Icon(
              Icons.notifications_active_rounded,
              color: AppColors.backgroundWarning, // Custom icon color
            ),
            iconRight: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textTertiary,
              size: 16,
            ),
            borderColor: AppColors.backgroundWarning, 
            backgroundColor: AppColors.backgroundCardDefault, 
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileSetupScreen(
                    onComplete: () {
                      debugPrint('Complete profile tapped!');
                      // Add any additional logic here
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          
          // Account Setting
          DetailedButton(
            text: 'Account Setting',
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
              debugPrint('Account Setting pressed!');
              AppShellScreen.navigateToIndex(context, 4);
            },
          ),
          const SizedBox(height: 8),

          // Application Info
          DetailedButton(
            text: 'Application Info',
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
              debugPrint('Application Info tapped!');
            },
          ),
          const SizedBox(height: 8),

          // Customer Services
          DetailedButton(
            text: 'Customer Services',
            iconLeft: const Icon(
              Icons.phone_in_talk_rounded,
              color: AppColors.surfaceSecondaryContrast,
            ),
            iconRight: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textTertiary,
              size: 16,
            ),
            onTap: () {
              debugPrint('Customer Services tapped!');
            },
          ),

          const SizedBox(height: 8),
          
          // Logout Button
          DetailedButton(
            text: 'Logout',
            iconLeft: const Icon(
              Icons.logout_rounded,
              color: AppColors.surfaceSecondaryContrast,
            ),
            iconRight: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textTertiary,
              size: 16,
            ),
            onTap: () async {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();
              
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
          
          // Add more space at the bottom if needed
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}