import 'package:flutter/material.dart';

class AppColors {
  // --- Brand/Primary Colors ---
  static const Color primaryPink = Color(0xFFF935A1);
  static const Color accentSecondary = Color(0xFFFF86B9);
  
  // --- Utility Colors ---
  static const Color utilityRed = Color(0xFFFF3838);
  static const Color utilityGreen = Color(0xFF20D56B);
  static const Color utilitySkyBlue = Color(0xFF7D97FF);

  // --- Surface Colors ---
  static const Color surfacePrimary = Color(0xFF20161A);
  static const Color surfaceSecondary = Color(0xFF332129);
  static const Color surfaceBorderPrimary = Color(0xFF48353D);
  static const Color surfaceSecondaryContrast = Color(0xFF997C89);
  static const Color surfacePrimaryContrast = Color(0xFFFED7E8); 

  // --- Text Colors ---
  static const Color textOnBrand = Color(0xFFF5F5F5); // White/Light Text (Text-Brand-On-Brand)
  static const Color textPrimary = Color(0xFFF2F2F2); // White/Light Text (Text-Neutral-On-Neutral)
  static const Color textSecondary = Color(0xFFB3B3B3); // Lighter Gray
  static const Color textTertiary = Color(0xFF767676); // Darker Gray (Used for '0.03 BNB')
  static const Color textWarning = Color(0xFF401B00);
  static const Color textWarningSecondary = Color(0xFF682D02);
  
  // --- Background/Other ---
  static const Color background = surfacePrimary; // Use darkest surface color as main background
  static const Color backgroundBrandHover = Color(0xFF1E1E1E);
  static const Color backgroundWarning = Color(0xFFE8B931); 
  static const Color backgroundBorder = Color(0xFF522404);
  static const Color backgroundGradient1 = Color(0xFF120C0E); 
  static const Color backgroundGradient2 = Color(0xFF121212);
  static const Color backgroundCardDefault = Color(0xFF2C2C2C);
  
  // --- Effects ---
  static const Color shadowColor = Color(0x3F000000);

}