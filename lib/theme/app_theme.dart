import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color cardBackground = Color(0xFF1A1A1A);
  static const Color borderColor = Color(0xFF2A2A2A);
  static const Color emeraldGreen = Color(0xFF064E3B);
  static const Color emeraldLight = Color(0xFF10B981);
  static const Color goldAccent = Color(0xFFD4AF37);
  static const Color textGray = Color(0xFF9CA3AF);
  static const Color textDarkGray = Color(0xFF6B7280);

  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'serif', // Gunakan font serif sesuai desain
    fontSize: 20,
  );
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: emeraldGreen,
        secondary: goldAccent,
        surface: cardBackground,
        background: darkBackground,
      ),
    );
  }
}