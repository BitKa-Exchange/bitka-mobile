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
    this.labelText = '',
    this.isPassword = false,
    this.suffixIcon,
    this.suffixLabel = '',
    this.validator,
    this.onSaved,
    this.controller,
  });

  // Factory constructor for pink variant
  factory InputField.pink({
    Key? key,
    String labelText = '',
    bool isPassword = false,
    Widget? suffixIcon,
    String? suffixLabel = '',
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    TextEditingController? controller,
  }) {
    return _PinkInputField(
      key: key,
      labelText: labelText,
      isPassword: isPassword,
      suffixIcon: suffixIcon,
      suffixLabel: suffixLabel,
      validator: validator,
      onSaved: onSaved,
      controller: controller,
    );
  }

  // Color getters that can be overridden in subclasses
  Color get textColor => AppColors.textPrimary;
  Color get textSecondary => AppColors.textTertiary;
  Color get primary => AppColors.primaryPink;
  Color get secondary => AppColors.backgroundCardDefault;
  Color get border => AppColors.surfaceBorderPrimary;
  Color get red => AppColors.utilityRed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        cursorColor: AppColors.primaryPink,
        cursorErrorColor: AppColors.utilityRed,
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: textColor),
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
          suffixIcon: suffixIcon ??
              Padding(
                padding: const EdgeInsets.only(),
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
            borderSide: BorderSide(
              width: 1.50,
              color: border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.50,
              color: primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.50,
              color: border,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.50,
              color: red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.50,
              color: red,
            ),
          ),
        ),
      ),
    );
  }
}

class _PinkInputField extends InputField {
  const _PinkInputField({
    super.key,
    super.labelText,
    super.isPassword,
    super.suffixIcon,
    super.suffixLabel,
    super.validator,
    super.onSaved,
    super.controller,
  });


  @override
  Color get textColor => AppColors.surfacePrimaryContrast;

  @override
  Color get textSecondary => AppColors.surfaceSecondaryContrast;

  @override
  Color get secondary => AppColors.surfaceSecondary;
}