import 'package:flutter/material.dart';

/// App color constants with ultra-modern Midnight & Electric Cyan palette
class AppColors {
  // Primary Colors (Electric Cyan / Flutter Blue)
  static const Color primary = Color(0xFF00D2FF);
  static const Color primaryDark = Color(0xFF0284C7);
  static const Color primaryLight = Color(0xFF38BDF8);

  // Accent Colors
  static const Color accentIndigo = Color(0xFF6366F1);
  static const Color accentViolet = Color(0xFF8B5CF6);
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color accentAmber = Color(0xFFF59E0B);
  static const Color accentPink = Color(0xFFEC4899);

  // Background Colors (Deep Cosmic Slate & Midnight Navy)
  static const Color background = Color(0xFF070B14);
  static const Color backgroundAlt = Color(0xFF0B1120);
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFF162033);
  static const Color surfaceCard = Color(0xFF131D31);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textTertiary = Color(0xFF64748B);

  // Glassmorphism Colors (using withValues to eliminate precision loss & warnings)
  static Color get glassSurface => Colors.white.withValues(alpha: 0.04);
  static Color get glassBorder => Colors.white.withValues(alpha: 0.08);
  static Color get glassHighlight => primary.withValues(alpha: 0.12);
  static Color get glassBorderHover => primary.withValues(alpha: 0.4);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D2FF), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFF00D2FF), Color(0xFF818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get glassGradient => LinearGradient(
    colors: [
      Colors.white.withValues(alpha: 0.07),
      Colors.white.withValues(alpha: 0.02),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get cardDarkGradient => LinearGradient(
    colors: [
      const Color(0xFF162033).withValues(alpha: 0.9),
      const Color(0xFF0F172A).withValues(alpha: 0.95),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> get primaryShadow => [
    BoxShadow(
      color: primary.withValues(alpha: 0.35),
      blurRadius: 28,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: primary.withValues(alpha: 0.2),
      blurRadius: 32,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get glassShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];
}
