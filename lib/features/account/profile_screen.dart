import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/shared/widgets/button.dart';
import 'package:bitka/shared/widgets/input_field.dart';
import 'package:bitka/shared/widgets/page_selector/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for form fields
  final _fullNameController = TextEditingController(text: 'Nattan Niparnee');
  final _dobController = TextEditingController(text: '23 July 1987');
  final _phoneController = TextEditingController(text: '28-132-5123');
  final _emailController = TextEditingController(text: 'nattan.niparnee@scoobydoo.com');
  
  String _selectedGender = 'Male';
  String _selectedNationality = 'China';

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
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
        appBar: CustomAppBar(title: "Profile"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                _FieldLabel(label: 'Full Name'),
                const SizedBox(height: 7),
                InputField(
                  labelText: '',
                  controller: _fullNameController,
                ),
                const SizedBox(height: 10),

                // Date of Birth
                _FieldLabel(label: 'Date of Birth'),
                const SizedBox(height: 7),
                InputField(
                  labelText: '',
                  controller: _dobController,
                  suffixIcon: const Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 10),

                // Gender
                _FieldLabel(label: 'Gender'),
                const SizedBox(height: 7),
                _DropdownField(
                  value: _selectedGender,
                  items: const ['Male', 'Female', 'Other'],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value ?? 'Male';
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Nationality
                _FieldLabel(label: 'Nationality'),
                const SizedBox(height: 7),
                _DropdownField(
                  value: _selectedNationality,
                  items: const ['China', 'Thailand', 'USA', 'UK', 'Japan', 'Other'],
                  onChanged: (value) {
                    setState(() {
                      _selectedNationality = value ?? 'China';
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Phone Number
                _FieldLabel(label: 'Phone Number'),
                const SizedBox(height: 7),
                InputField(
                  labelText: '',
                  controller: _phoneController,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      '+66',
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Email
                _FieldLabel(label: 'Email'),
                const SizedBox(height: 7),
                InputField(
                  labelText: '',
                  controller: _emailController,
                ),
                const SizedBox(height: 20),

                // Next Button
                Button(
                  label: "Next",
                  type: ButtonType.primary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      debugPrint('Form submitted');
                      // Handle form submission
                    }
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

/// Field Label Widget - Reusable label for form fields
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

/// Dropdown Field Widget - Styled to match InputField
class _DropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.value,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: AppColors.surfaceBorderPrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: AppColors.surfaceBorderPrimary,
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