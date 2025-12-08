import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/account/setup_pages/profile_setup_consent_screen.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileSetupContactScreen extends StatefulWidget {
  final VoidCallback? onComplete;
  
  const ProfileSetupContactScreen({super.key, this.onComplete});

  @override
  State<ProfileSetupContactScreen> createState() => _ProfileSetupContactScreenState();
}

class _ProfileSetupContactScreenState extends State<ProfileSetupContactScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Indicator
                  const _ProgressIndicator(currentStep: 2),
                  const SizedBox(height: 24),

                  // Section Title
                  const Text(
                    'Contact Info',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Phone Number
                  _FieldLabel(label: 'Phone Number (optional)'),
                  const SizedBox(height: 7),
                  InputField(
                    labelText: 'Your phone Number',
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _FieldLabel(label: 'Email (optional)'),
                  const SizedBox(height: 7),
                  InputField(
                    labelText: 'Your email Address',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 40),

                  // Next Button
                  Button(
                    label: "Next",
                    type: ButtonType.primary,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileSetupConsentScreen(
                            onComplete: widget.onComplete,
                          ),
                        ),
                      );
                    },
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

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  static const _labelStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
    height: 1.40,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        SizedBox(
          height: 22,
          child: FittedBox(
            child: Text(label, style: _labelStyle),
          ),
        ),
      ],
    );
  }
}