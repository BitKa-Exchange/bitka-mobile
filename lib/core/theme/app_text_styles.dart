import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles for the app.
/// 
/// These styles define fontSize, fontWeight, height, and optionally color.
/// Font family is intentionally omitted - apply it at the theme level or
/// use `.copyWith(fontFamily: 'YourFont')` when needed.
abstract final class AppTextStyles {
  // ============================================================
  // DISPLAY / LARGE TITLES
  // ============================================================
  
  /// Large title - 34px, w800
  /// Used in: account_setting_screen (Account Setting title)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  /// App bar title - 29px, w800, height 1.40
  /// Used in: custom_appbar
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.w800,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  /// Section title - 24px, w800
  /// Used in: wallet_screen (Coins header)
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  /// Section title medium - 20px, w800
  /// Used in: profile_setup_screen, profile_setup_contact_screen, performance_card
  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  // ============================================================
  // BODY / CONTENT STYLES
  // ============================================================

  /// Primary button/chip text - 17px, w800, height 1.40
  /// Used in: detailed_button (main text), custom_chip (surfacePrimary)
  static const TextStyle bodyLargeBold = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w800,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  /// Dropdown title - 17px, w700, height 1.40
  /// Used in: detailed_dropdown (title), custom_chip (surfacePrimary label)
  static const TextStyle bodyLargeSemiBold = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  /// Standard body text bold - 16px, w800, height 1.40
  /// Used in: button, wallet_history_control, custom_chip, input_field suffix
  static const TextStyle bodyMediumBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  /// Subtitle/label style - 16px, w900, height 1.40
  /// Used in: withdraw_screen, deposit_screen, order_confirm_screen, 
  ///          order_succeed_screen, profile_setup screens (field labels)
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    height: 1.40,
    color: AppColors.textSecondary,
  );

  /// Standard body text semibold - 16px, w600, height 1.40
  /// Used in: agreement_field, wallet_screen (date group)
  static const TextStyle bodyMediumSemiBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMediumSemiBoldSquished = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.40,
    color: AppColors.textPrimary,
  );
  /// Standard body text regular - 16px, w400, height 1.40
  /// Used in: input_field (label), trading_main_screen (_subStyle)
  static const TextStyle bodyMediumRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  /// Detail/hint text - 16px, w500, height 1.40
  /// Used in: withdraw_screen (_detailStyle)
  static const TextStyle bodyMediumMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.40,
    color: AppColors.textTertiary,
  );

  // ============================================================
  // SMALL / CAPTION STYLES
  // ============================================================

  /// Small text bold - 14px, w800
  /// Used in: trading_asset_screen (subTextStyle)
  static const TextStyle bodySmallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Small text semibold - 14px, w600
  /// Used in: icon_card, custom_chip (pinkOutlined, pinkTint), 
  ///          trading_main_screen (_priceStyle, trend styles), detailed_button (detail)
  static const TextStyle bodySmallSemiBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Small detail text medium - 14px, w500, height 1.40
  /// Used in: order_succeed_screen (_detailStyle1)
  static const TextStyle captionMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.40,
    color: AppColors.textTertiary,
  );

  /// Small detail text bold - 14px, w700, height 1.40
  /// Used in: order_succeed_screen (_detailStyle2)
  static const TextStyle captionBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.40,
    color: AppColors.textTertiary,
  );

  /// Extra small text bold - 12px, w800, height 1.40
  /// Used in: detailed_dropdown (description), detailed_button (subText, subRightText)
  static const TextStyle captionSmallBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    height: 1.40,
    color: AppColors.textPrimary,
  );

  /// Chip/pill text - 13px, bold
  /// Used in: binary_chip
  static const TextStyle chipText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // ============================================================
  // SEMANTIC / UTILITY STYLES
  // ============================================================

  /// Bullish/positive trend - 14px, w600, green
  static const TextStyle trendBullish = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.utilityGreen,
  );

  /// Bearish/negative trend - 14px, w600, red
  static const TextStyle trendBearish = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.utilityRed,
  );

  /// Neutral trend - 14px, w600, secondary text
  static const TextStyle trendNeutral = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  /// Input label style - 16px, w400, height 1.40, tertiary color
  static const TextStyle inputLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.40,
    color: AppColors.textTertiary,
  );

  /// Link text style - 16px, w600, height 1.40, pink with underline
  static const TextStyle linkText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.40,
    color: AppColors.primaryPink,
    decoration: TextDecoration.underline,
  );
}
