import 'package:flutter/material.dart';

/// App color constants with Flutter Blue accent theme
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF00C8FF); // Flutter Blue
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color primaryLight = Color(0xFF66DDFF);

  // Background Colors
  static const Color background = Color(0xFF0A0A0A); // Deep Dark
  static const Color surface = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textTertiary = Color(0xFF808080);

  // Glassmorphism Colors
  static Color get glassSurface => Colors.white.withOpacity(0.05);
  static Color get glassBorder => Colors.white.withOpacity(0.1);
  static Color get glassHighlight => primary.withOpacity(0.1);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get glassGradient => LinearGradient(
    colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> get primaryShadow => [
    BoxShadow(
      color: primary.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> get glassShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];
}
