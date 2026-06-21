import 'package:flutter/material.dart';

abstract final class AppColors {
  // Navy Base
  static const Color navyDeep = Color(0xFF050D1F);
  static const Color navyDark = Color(0xFF0A1628);
  static const Color navyMid = Color(0xFF0F2040);
  static const Color navyLight = Color(0xFF1A3058);
  static const Color navyAccent = Color(0xFF1E3A6E);

  // Gold Palette
  static const Color goldPure = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE8C96B);
  static const Color goldBright = Color(0xFFF5E08A);
  static const Color goldDark = Color(0xFFB8962E);
  static const Color goldDim = Color(0xFF9C7E1E);
  static const Color goldMuted = Color(0xFF6B5512);

  // Glass / Surface
  static const Color glassSurface = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x26FFFFFF);
  static const Color glassBorderBright = Color(0x4DFFFFFF);
  static const Color glassOverlay = Color(0x0DFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0C4DE);
  static const Color textMuted = Color(0xFF6B8BAE);
  static const Color textHint = Color(0xFF3D5A7A);

  // Status
  static const Color success = Color(0xFF2ECC71);
  static const Color successLight = Color(0x1A2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color warningLight = Color(0x1AF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color errorLight = Color(0x1AE74C3C);
  static const Color info = Color(0xFF3498DB);
  static const Color infoLight = Color(0x1A3498DB);

  // Seat states
  static const Color seatAvailable = Color(0xFF2ECC71);
  static const Color seatSelected = Color(0xFFD4AF37);
  static const Color seatOccupied = Color(0xFF3D5A7A);
  static const Color seatPremium = Color(0xFF9B59B6);

  // Gradients helpers
  static const List<Color> navyGradient = [navyDeep, navyMid];
  static const List<Color> goldGradient = [goldDim, goldPure, goldLight];
  static const List<Color> heroGradient = [navyDeep, navyAccent];
}
