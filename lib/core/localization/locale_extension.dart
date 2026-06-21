import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'locale_cubit.dart';
import 'locale_state.dart';

export 'locale_cubit.dart';
export 'locale_state.dart';

extension BuildContextLocale on BuildContext {
  /// Read the cubit without rebuilding on state change.
  LocaleCubit get localeCubit => read<LocaleCubit>();

  /// Watch the current locale state — rebuilds when locale changes.
  LocaleState get localeState => watch<LocaleCubit>().state;

  /// Current active [Locale].
  Locale get appLocale => localeState.locale;

  /// Whether the app is currently in Arabic.
  bool get isArabic => localeState.isArabic;

  /// Whether the app is currently in English.
  bool get isEnglish => localeState.isEnglish;

  /// Switch to a specific locale.
  void setLocale(Locale locale) => localeCubit.setLocale(locale);

  /// Read locale state without listening — safe in callbacks and event handlers.
  LocaleState get readLocaleState => read<LocaleCubit>().state;

  /// Whether the app is in Arabic (read-only, safe outside build).
  bool get isArabicValue => readLocaleState.isArabic;

  /// Whether the app is in English (read-only, safe outside build).
  bool get isEnglishValue => readLocaleState.isEnglish;

  /// Toggle between Arabic and English.
  void toggleLocale() => localeCubit.toggleLocale();
}
