import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/account/setup_pages/profile_setup_complete_screen.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileSetupConsentScreen extends StatefulWidget {
  final VoidCallback? onComplete;
  
  const ProfileSetupConsentScreen({super.key, this.onComplete});

  @override
  State<ProfileSetupConsentScreen> createState() => _ProfileSetupConsentScreenState();
}

class _ProfileSetupConsentScreenState extends State<ProfileSetupConsentScreen> {
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;

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
        appBar: CustomAppBar(title: "Profile Setup"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Indicator
                const _ProgressIndicator(currentStep: 3),
                const SizedBox(height: 24),

                // Section Title
                const Text(
                  'Consent & Declaration',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),

                // Terms and Condition Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundBrandHover,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Terms And Condition',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Welcome to Bitka, a digital application designed for cryptocurrency education, exploration, and simulated transactions. By creating an account or using Bitka, you agree to the following Terms and Conditions:',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '1. Acceptance of Terms',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'By accessing or using Bitka, you agree to comply with these Terms. If you do not agree, please discontinue use of the app immediately.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '2. Nature of Service',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Bitka provides features related to cryptocurrency information, portfolio simulation, and basic wallet functionality.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Checkboxes
                _CheckboxRow(
                  label: 'Agree to Terms & Conditions',
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 12),
                _CheckboxRow(
                  label: 'Agree to Privacy Policy',
                  value: _agreedToPrivacy,
                  onChanged: (value) {
                    setState(() {
                      _agreedToPrivacy = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 40),

                // Complete Button
                Button(
                  label: "Complete",
                  type: ButtonType.primary,
                  onPressed: (_agreedToTerms && _agreedToPrivacy)
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileSetupCompleteScreen(
                                onComplete: widget.onComplete,
                              ),
                            ),
                          );
                        }
                      : null,
                ),
                const SizedBox(height: 16),

                // Return Button
                Button(
                  label: "Return",
                  type: ButtonType.secondary,
                  onPressed: () {
                    Navigator.of(context).pop();
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

// -------------------------------------------------------------------
// Reusable Components
// -------------------------------------------------------------------

class _ProgressIndicator extends StatelessWidget {
  final int currentStep;

  const _ProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index < currentStep;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryPink : AppColors.surfaceBorderPrimary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _CheckboxRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryPink,
            checkColor: AppColors.textPrimary,
            side: const BorderSide(
              color: AppColors.surfaceBorderPrimary,
              width: 2,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}