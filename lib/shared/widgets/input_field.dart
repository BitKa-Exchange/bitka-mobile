import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';


class InputField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? suffixLabel;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.suffixIcon,
    this.suffixLabel = '',
    this.validator,
    this.onSaved,
    this.controller,
  });

  static const textColor = AppColors.textPrimary;
  static const textSecondary = AppColors.textTertiary;
  static const primary = AppColors.primaryPink;
  static const secondary = AppColors.backgroundCardDefault;
  static const border = AppColors.surfaceBorderPrimary;
  static const red = AppColors.utilityRed;

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

      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: textColor), 
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          fillColor: secondary, 
          filled: true,
          labelText: labelText,
          labelStyle: AppTextStyles.inputLabel.copyWith(
            fontFamily: 'Montserrat',
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 50, maxWidth: 50),
          suffixIcon: suffixIcon ?? Padding(
                padding: const EdgeInsets.only(),//only(right: 16.0),
                child: Text(
                  suffixLabel ?? 'Label',
                  style: AppTextStyles.bodyMediumBold.copyWith(
                    fontFamily: 'Montserrat',
                    color: textSecondary,
                  ),
                ),
              ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.50,
              color: red,
            ),
          ),
        ),
      ),
    );
  }
}