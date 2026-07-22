import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF090D16);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceCard = Color(0xFF151D30);
  static const Color surfaceCardBorder = Color(0xFF1E293D);

  // Accents
  static const Color primaryTeal = Color(0xFF00E699);
  static const Color primaryTealGlow = Color(0x3300E699);
  static const Color primaryTealDark = Color(0xFF00A86B);

  static const Color accentGold = Color(0xFFFFB800);
  static const Color accentGoldGlow = Color(0x33FFB800);

  static const Color accentRed = Color(0xFFFF3355);
  static const Color accentRedGlow = Color(0x44FF3355);

  // Date Pills
  static const Color datePillSelected = Colors.white;
  static const Color datePillUnselected = Color(0xFF111726);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient dailyGoalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF16233B),
      Color(0xFF0D1424),
      Color(0xFF090E1A),
    ],
  );

  static const LinearGradient bannerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF261E0A),
      Color(0xFF1F1807),
      Color(0xFF141005),
    ],
  );

  static const LinearGradient navBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF151C2C),
      Color(0xFF0D121F),
    ],
  );
}
