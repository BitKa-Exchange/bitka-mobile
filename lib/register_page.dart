import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'main.dart'; // Import for color constants

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _allowData1 = false;
  bool _allowData2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // "Register" Title
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // Form Fields
              const TextField(
                decoration: InputDecoration(hintText: 'Username'),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(hintText: 'Confirm-Password'),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              // Checkboxes
              _buildCheckboxRow(
                'Allow us to sold ur data',
                _allowData1,
                (value) => setState(() => _allowData1 = value ?? false),
              ),
              const SizedBox(height: 16),
              _buildCheckboxRow(
                'Allow us to sold ur data',
                _allowData2,
                (value) => setState(() => _allowData2 = value ?? false),
              ),
              const SizedBox(height: 60),
              // Register Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the disclaimer page
                  Navigator.pushNamed(context, '/disclaimer');
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the checkbox row
  Widget _buildCheckboxRow(String text, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: primaryPink,
          checkColor: Colors.white,
          side: const BorderSide(color: Colors.white),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white),
              children: [
                TextSpan(text: '$text '),
                TextSpan(
                  text: 'read agreement',
                  style: const TextStyle(color: primaryPink),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle "read agreement" tap
                      print('Read agreement tapped');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}