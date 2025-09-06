import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette based on job-app design
  static const Color primaryBlue = Color(0xFF3B82F6); // blue-500
  static const Color primaryPurple = Color(0xFF9333EA); // purple-600
  static const Color secondaryBlue = Color(0xFF1D4ED8); // blue-700
  static const Color secondaryPurple = Color(0xFF7C3AED); // purple-700
  
  static const Color backgroundLight = Color(0xFFF3F4F6); // gray-100
  static const Color backgroundDark = Color(0xFF111827); // gray-900
  static const Color cardLight = Color(0xFFFFFFFF); // white
  static const Color cardDark = Color(0xFF1F2937); // gray-800
  
  static const Color textPrimaryLight = Color(0xFF111827); // gray-900
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // gray-100
  static const Color textSecondaryLight = Color(0xFF6B7280); // gray-500
  static const Color textSecondaryDark = Color(0xFF9CA3AF); // gray-400
  
  static const Color success = Color(0xFF10B981); // green-500
  static const Color warning = Color(0xFFF59E0B); // amber-500
  static const Color error = Color(0xFFEF4444); // red-500
  static const Color info = Color(0xFF3B82F6); // blue-500
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient primaryGradientDark = LinearGradient(
    colors: [secondaryBlue, secondaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: primaryPurple,
      surface: cardLight,
      background: backgroundLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimaryLight,
      onBackground: textPrimaryLight,
      error: error,
      onError: Colors.white,
      surfaceVariant: Color(0xFFF3F4F6), // gray-100
      onSurfaceVariant: Color(0xFF6B7280), // gray-500
    ),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: cardLight,
      foregroundColor: textPrimaryLight,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shadowColor: Colors.black.withOpacity(0.1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: error),
      ),
      labelStyle: const TextStyle(color: textSecondaryLight),
      hintStyle: const TextStyle(color: textSecondaryLight),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: cardLight,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textSecondaryLight,
      elevation: 8,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE5E7EB), // gray-200
      thickness: 1,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: textPrimaryLight,
      iconColor: textSecondaryLight,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: primaryPurple,
      surface: cardDark,
      background: backgroundDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimaryDark,
      onBackground: textPrimaryDark,
      error: error,
      onError: Colors.white,
      surfaceVariant: Color(0xFF374151), // gray-700
      onSurfaceVariant: Color(0xFFD1D5DB), // gray-300
    ),
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: cardDark,
      foregroundColor: textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black.withOpacity(0.3),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF374151)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF374151)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: error),
      ),
      labelStyle: const TextStyle(color: textSecondaryDark),
      hintStyle: const TextStyle(color: textSecondaryDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: cardDark,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textSecondaryDark,
      elevation: 8,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF374151),
      thickness: 1,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: textPrimaryDark,
      iconColor: textSecondaryDark,
    ),
  );
}
