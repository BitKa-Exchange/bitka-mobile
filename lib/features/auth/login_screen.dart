import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/features/auth/register_screen.dart';
import 'package:bitka/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/button.dart';
import '../../shared/widgets/input_field.dart';
import '../../shared/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Define a GlobalKey for the Form
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(_username, _password);
      
      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AppShellScreen(),
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login failed'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                
                // --- Login Title ---
                const Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                
                // 2. The Form widget wrapping the inputs
                Form(
                  key: _formKey, // Assign the key
                  child: Column(
                    children: [
                      // --- Username Field (InputField wraps TextFormField) ---
                      InputField(
                        labelText: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username.';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value ?? '',
                      ),
                      const SizedBox(height: 12),
                      
                      // --- Password Field (InputField wraps TextFormField) ---
                      InputField(
                        labelText: 'Password',
                        isPassword: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_sharp, color: AppColors.textTertiary),
                          onPressed: () {
                            debugPrint("TODO: make visable button work");
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value ?? '',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // --- Sign-in with Text ---
                const Center(
                  child: Text(
                    'or sign-in with',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
  
                // --- Social Buttons ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(icon: Icons.facebook, onPressed: () => debugPrint('Facebook login')),
                    const SizedBox(width: 16),
                    SocialButton(icon: Icons.apple, onPressed: () => debugPrint('Apple login')),
                    const SizedBox(width: 16),
                    SocialButton(icon: Icons.g_mobiledata_rounded, onPressed: () => debugPrint('Google login')),
                  ],
                ),
                
                const SizedBox(height: 30),

                // --- Action Buttons ---
                Button(
                  label: 'Login',
                  type: ButtonType.primary,
                  onPressed: _handleLogin,
                ),

                const SizedBox(height: 12),
                Button(
                  label: 'Register',
                  type: ButtonType.secondary,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 20),
                
                // --- Forget Password ---
                const Center(
                  child: Text(
                    'forget password?',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
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