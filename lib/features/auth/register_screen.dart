import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/button.dart';
import '../../shared/widgets/input_field.dart';
import '../../shared/widgets/agreement_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Global Key for form validation
  final _formKey = GlobalKey<FormState>();

  // State variables for form fields and agreements
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isTermsChecked = false;
  bool _isPrivacyChecked = false;

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png', // Assuming logo is available here
          width: 134,
          height: 134,
        ),
        const SizedBox(height: 10),
        const Text(
          'Bitka',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 32,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  void _handleRegistration() {
    // 1. Validate the form fields first
    if (!_formKey.currentState!.validate()) {
      debugPrint('Form validation failed.');
      return;
    }

    // 2. Check agreement checkboxes
    if (!_isTermsChecked || !_isPrivacyChecked) {
      debugPrint('Please agree to all terms and policies.');
      // Optionally show a SnackBar error here
      return;
    }

    _formKey.currentState!.save(); // Save the data to state variables
    debugPrint('Registration successful! User: $_username, Email: $_email');
    // Proceed with API call or navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Match LoginScreen's background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [AppColors.backgroundGradient1, AppColors.backgroundGradient2],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                
                // --- Logo ---
                _buildLogo(),
                
                const SizedBox(height: 50),
                
                // --- Register Title ---
                const Text(
                  'Register',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                
                // --- Form Wrapper ---
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // 1. Username Field
                      InputField(
                        labelText: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Username is required.';
                          return null;
                        },
                        onSaved: (value) => _username = value ?? '',
                      ),
                      const SizedBox(height: 12),
                      
                      // 2. Email Field
                      InputField(
                        labelText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Email is required.';
                          // Simple email format check
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value ?? '',
                      ),
                      const SizedBox(height: 12),
                      
                      // 3. Password Field
                      InputField(
                        labelText: 'Password',
                        isPassword: true,
                        suffixIcon: const Icon(Icons.remove_red_eye_sharp, color: AppColors.textTertiary),
                        validator: (value) {
                          if (value == null || value.length < 6) return 'Password must be at least 6 characters.';
                          return null;
                        },
                        onSaved: (value) => _password = value ?? '',
                      ),
                      const SizedBox(height: 12),
                      
                      // 4. Confirm Password Field
                      InputField(
                        labelText: 'Confirm-Password',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please confirm your password.';
                          if (value != _password) return 'Passwords do not match.';
                          return null;
                        },
                        // We don't necessarily need onSaved for this field, but keeping it for completeness
                        onSaved: (value) => _confirmPassword = value ?? '',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),

                // --- Agreement Checkboxes ---
                
                // Terms Agreement
                AgreementField(
                  agreementText: 'I agree to the Terms of Service',
                  isChecked: _isTermsChecked,
                  onChecked: (bool? newValue) {
                    setState(() {
                      _isTermsChecked = newValue ?? false;
                    });
                  },
                  onLinkTap: () => debugPrint('Viewing Terms of Service'),
                  linkText: 'read agreement',
                ),
                const SizedBox(height: 8),

                // Privacy Agreement
                AgreementField(
                  agreementText: 'I agree to the Privacy Policy',
                  isChecked: _isPrivacyChecked,
                  onChecked: (bool? newValue) {
                    setState(() {
                      _isPrivacyChecked = newValue ?? false;
                    });
                  },
                  onLinkTap: () => debugPrint('Viewing Privacy Policy'),
                  linkText: 'read agreement',
                ),
                
                const SizedBox(height: 30),

                // --- Register Button ---
                Button(
                  label: 'Register',
                  type: ButtonType.primary,
                  onPressed: _handleRegistration,
                ),
                
                const SizedBox(height: 20),
                
                // --- Back to Login Link ---
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(), // Navigate back to LoginScreen
                  child: const Center(
                    child: Text(
                      'already have an account? Login',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}