import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileSetupCompleteScreen extends StatelessWidget {
  final VoidCallback? onComplete;
  
  const ProfileSetupCompleteScreen({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment(0.50, -0.00),
        //   end: Alignment(0.50, 1.00),
        //   colors: [AppColors.backgroundGradient1, AppColors.backgroundGradient2],
        // ),
        color: AppColors.surfacePrimary,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Success Title
                const Text(
                  'Profile Setup',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Complete!',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 40),

                // Success Icon
                const Icon(
                  Icons.verified_user_outlined,
                  size: 120,
                  color: AppColors.textOnBrand,
                ),
                const SizedBox(height: 32),

                // Description
                const Text(
                  'You can edit your profile anytime',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const Spacer(),

                // Return to Setting Button
                Button(
                  label: "Return to Setting",
                  type: ButtonType.primary,
                  onPressed: () {
                    // Call the completion callback
                    if (onComplete != null) {
                      onComplete!();
                    }
                    // Navigate back to settings or home
                    Navigator.of(context).popUntil((route) => route.isFirst);
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