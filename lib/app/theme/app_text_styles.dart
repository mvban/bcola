import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Display
  static TextStyle displayLarge = GoogleFonts.playfairDisplay(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.espressoBrown,
    letterSpacing: -0.5,
  );

  static TextStyle displayMedium = GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.espressoBrown,
  );

  static TextStyle displaySmall = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.espressoBrown,
  );

  // Display on dark
  static TextStyle displayLargeOnDark = GoogleFonts.playfairDisplay(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.warmCream,
    letterSpacing: -0.5,
  );

  static TextStyle displayMediumOnDark = GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.warmCream,
  );

  static TextStyle displaySmallOnDark = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.warmCream,
  );

  // Headings
  static TextStyle headlineLarge = GoogleFonts.lora(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.espressoBrown,
  );

  static TextStyle headlineMedium = GoogleFonts.lora(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.espressoBrown,
  );

  static TextStyle headlineSmall = GoogleFonts.lora(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.espressoBrown,
  );

  // Body
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.espressoBrown,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.espressoBrownLight,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.warmWood,
    height: 1.4,
  );

  // Labels
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.espressoBrown,
    letterSpacing: 0.5,
  );

  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.warmWood,
    letterSpacing: 0.8,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.warmWood,
    letterSpacing: 1.0,
  );

  // Special
  static TextStyle price = GoogleFonts.playfairDisplay(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.trattoriaRed,
  );

  static TextStyle priceSmall = GoogleFonts.playfairDisplay(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.trattoriaRed,
  );

  static TextStyle category = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.trattoriaRed,
    letterSpacing: 1.5,
  );

  static TextStyle italic = GoogleFonts.playfairDisplay(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: AppColors.warmWood,
  );

  static TextStyle tagline = GoogleFonts.lora(
    fontSize: 13,
    fontStyle: FontStyle.italic,
    color: AppColors.warmCream,
    height: 1.5,
  );

  static TextStyle cardNumber = GoogleFonts.playfairDisplay(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.espressoBrown,
  );
}
