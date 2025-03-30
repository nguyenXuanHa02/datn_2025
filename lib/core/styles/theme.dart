import 'package:flutter/material.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';
import 'package:kichikichi/core/styles/text_styles/app_text_style.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.card,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: AppTextStyles.heading1.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      bodyLarge: AppTextStyles.bodyText,
      bodyMedium: AppTextStyles.caption,
      labelLarge: AppTextStyles.buttonText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonPrimary,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.buttonText,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.buttonText,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: AppTextStyles.caption,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      titleTextStyle: AppTextStyles.heading1.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(color: Colors.white),
      displayMedium: AppTextStyles.heading2.copyWith(color: Colors.white70),
      bodyLarge: AppTextStyles.bodyText.copyWith(color: Colors.white60),
      bodyMedium: AppTextStyles.caption.copyWith(color: Colors.white54),
      labelLarge: AppTextStyles.buttonText.copyWith(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonPrimary,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.buttonText,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.buttonText,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      hintStyle: AppTextStyles.caption.copyWith(color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
  );
}
