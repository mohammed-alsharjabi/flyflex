import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double card = 20.0;
  static const double button = 14.0;
  static const double chip = 50.0;
  static const double circle = 100.0;

  static BorderRadius get cardBorderRadius =>
      BorderRadius.circular(card);

  static BorderRadius get buttonBorderRadius =>
      BorderRadius.circular(button);

  static BorderRadius get chipBorderRadius =>
      BorderRadius.circular(chip);

  static BorderRadius get xl2BorderRadius =>
      BorderRadius.circular(xxl);
}
