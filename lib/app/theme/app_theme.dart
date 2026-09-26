import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.trattoriaRed,
        onPrimary: AppColors.warmCream,
        primaryContainer: AppColors.trattoriaRedDark,
        onPrimaryContainer: AppColors.warmCream,
        secondary: AppColors.goldenYellow,
        onSecondary: AppColors.espressoBrown,
        secondaryContainer: AppColors.goldenYellowLight,
        onSecondaryContainer: AppColors.espressoBrown,
        tertiary: AppColors.warmWood,
        onTertiary: AppColors.softWhite,
        tertiaryContainer: AppColors.warmWoodLight,
        onTertiaryContainer: AppColors.espressoBrown,
        error: Colors.red.shade700,
        onError: Colors.white,
        errorContainer: Colors.red.shade100,
        onErrorContainer: Colors.red.shade900,
        surface: AppColors.softWhite,
        onSurface: AppColors.espressoBrown,
        surfaceContainerHighest: AppColors.warmCream,
        onSurfaceVariant: AppColors.espressoBrownLight,
        outline: AppColors.warmWood,
        outlineVariant: AppColors.divider,
        shadow: AppColors.shadow,
        scrim: AppColors.overlay,
        inverseSurface: AppColors.espressoBrown,
        onInverseSurface: AppColors.warmCream,
        inversePrimary: AppColors.goldenYellow,
      ),
      scaffoldBackgroundColor: AppColors.warmCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.trattoriaRed,
        foregroundColor: AppColors.warmCream,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.softWhite,
        elevation: 2,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.trattoriaRed,
          foregroundColor: AppColors.warmCream,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.trattoriaRed,
          side: const BorderSide(color: AppColors.trattoriaRed, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.warmCream,
        selectedColor: AppColors.trattoriaRed,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.espressoBrown,
        ),
        secondaryLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.warmCream,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.divider),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.softWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.trattoriaRed, width: 2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.softWhite,
        selectedItemColor: AppColors.trattoriaRed,
        unselectedItemColor: AppColors.warmWood,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.softWhite,
        indicatorColor: AppColors.trattoriaRed.withOpacity(0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.trattoriaRed);
          }
          return const IconThemeData(color: AppColors.warmWood);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.trattoriaRed,
            );
          }
          return const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.warmWood,
          );
        }),
      ),
    );
  }
}
