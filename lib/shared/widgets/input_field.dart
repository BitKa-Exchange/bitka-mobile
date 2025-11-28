import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';


class InputField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller; // Added controller support

  const InputField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.controller,
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
      // This is the critical widget that MUST be a descendant of the Form
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: AppColors.textPrimary), 
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          fillColor: AppColors.surfacePrimary, 
          filled: true,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppColors.textTertiary,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            height: 1.40,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          
          // Define the border style for normal, focus, and error states
          border: OutlineInputBorder(
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}