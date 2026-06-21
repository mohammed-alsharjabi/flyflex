import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExt on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}

extension DateTimeExt on DateTime {
  String get formattedDate => DateFormat('dd MMM yyyy').format(this);
  String get formattedTime => DateFormat('HH:mm').format(this);
  String get shortDate => DateFormat('dd MMM').format(this);
  String get dayOfWeek => DateFormat('EEEE').format(this);
  String get monthYear => DateFormat('MMMM yyyy').format(this);
}

extension DoubleExt on double {
  String get asCurrency => NumberFormat.currency(
        symbol: 'SAR ',
        decimalDigits: 0,
      ).format(this);

  String get asCompactCurrency => NumberFormat.compactCurrency(
        symbol: 'SAR ',
        decimalDigits: 0,
      ).format(this);
}

extension IntExt on int {
  String get asCurrency => toDouble().asCurrency;

  String get minutesToDuration {
    final hours = this ~/ 60;
    final minutes = this % 60;
    if (hours == 0) return '${minutes}m';
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }
}

extension StringExt on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');
}

extension ListExt<T> on List<T> {
  List<T> get shuffled => [...this]..shuffle();
}
