import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/features/account/setup_pages/profile_setup_contact_screen.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
  final VoidCallback? onComplete;
  
  const ProfileSetupScreen({super.key, this.onComplete});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  
  String _selectedGender = 'Male';
  String _selectedNationality = 'Thai';

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  static const _labelStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
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
                  const _ProgressIndicator(currentStep: 1),
                  const SizedBox(height: 24),

                  // Section Title
                  const Text(
                    'Personal Info',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Full Name
                  _FieldLabel(label: 'Full Name'),
                  const SizedBox(height: 7),
                  InputField(
                    labelText: 'Your name',
                    controller: _fullNameController,
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth
                  _FieldLabel(label: 'Date of Birth'),
                  const SizedBox(height: 7),
                  InputField(
                    labelText: 'Your birth Date',
                    controller: _dobController,
                    suffixIcon: const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Gender
                  _FieldLabel(label: 'Gender'),
                  const SizedBox(height: 7),
                  _DropdownField(
                    value: _selectedGender,
                    placeholder: 'Your gender',
                    items: const ['Male', 'Female', 'Other'],
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value ?? 'Male';
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Nationality
                  _FieldLabel(label: 'Nationality'),
                  const SizedBox(height: 7),
                  _DropdownField(
                    value: _selectedNationality,
                    placeholder: 'Your nationality',
                    items: const ['Thai', 'Chinese', 'American', 'Japanese', 'Other'],
                    onChanged: (value) {
                      setState(() {
                        _selectedNationality = value ?? 'Thai';
                      });
                    },
                  ),
                  const SizedBox(height: 40),

                  // Next Button
                  Button(
                    label: "Next",
                    type: ButtonType.primary,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileSetupContactScreen(
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

class _DropdownField extends StatelessWidget {
  final String value;
  final String placeholder;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.value,
    required this.placeholder,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: AppColors.backgroundCardDefault,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: AppColors.backgroundCardDefault,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: placeholder,
          hintStyle: const TextStyle(
            color: AppColors.textTertiary,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: AppColors.borderDefaultTertiary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: AppColors.borderDefaultTertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: AppColors.primaryPink,
            ),
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textPrimary,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}