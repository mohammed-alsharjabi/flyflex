import 'package:flutter/material.dart';
import 'package:fly_flex/core/localization/locale_extension.dart';

class CountryModel {
  const CountryModel({
    required this.code,
    required this.nameEn,
    required this.nameAr,
    required this.dialCode,
    required this.flagEmoji,
  });

  final String code;
  final String nameEn;
  final String nameAr;
  final String dialCode;
  final String flagEmoji;

  String localizedName(BuildContext context) =>
      context.isArabicValue ? nameAr : nameEn;

  String get displayWithDial => '$flagEmoji $dialCode';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel && code == other.code;

  @override
  int get hashCode => code.hashCode;
}
