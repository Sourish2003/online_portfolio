import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light theme colors
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.light,
      primary: const Color(0xFF6750A4),
      onPrimary: Colors.white,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.black,
      tertiary: const Color(0xFFFF8A65),
      surface: Colors.white,
      background: const Color(0xFFF8F8F8),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 60,
        color: Colors.black,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 48,
        color: Colors.black,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.black87,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 18,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
  );

  // Dark theme colors
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.dark,
      primary: const Color(0xFFBB86FC),
      onPrimary: Colors.black,
      secondary: const Color(0xFF03DAC6),
      onSecondary: Colors.black,
      tertiary: const Color(0xFFFF8A65),
      surface: const Color(0xFF121212),
      background: const Color(0xFF121212),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 60,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 48,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.white70,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 18,
        color: Colors.white70,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
  );
}
